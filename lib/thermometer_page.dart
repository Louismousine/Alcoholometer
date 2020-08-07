import 'dart:convert';

import 'package:alcool_app/add_drink_popup.dart';
import 'package:alcool_app/helper.dart';
import 'package:alcool_app/main.dart';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class ThermometerPage extends StatefulWidget {
  static const routeName = '/thermometer';

  @override
  _ThermometerPageState createState() => _ThermometerPageState();
}

class _ThermometerPageState extends State<ThermometerPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final user =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final name = user['name'];
    final weight = user['weight'];
    final height = user['height'];
    final isFemale = user['isFemale'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.pink,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              addDrink(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                isFemale
                    ? Text(
                        'Female',
                        style: TextStyle(fontSize: 20),
                      )
                    : Text(
                        'Male',
                        style: TextStyle(fontSize: 20),
                      ),
                Text(
                  weight.toString() + ' lbs',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  height.toString() + ' cm',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height / 1.5,
              child: LiquidLinearProgressIndicator(
                value: Helper.getPourcentage(name),
                valueColor: AlwaysStoppedAnimation(
                  Colors.pink,
                ),
                backgroundColor: Colors.white,
                borderColor: Colors.red,
                borderWidth: 5.0,
                borderRadius: 12.0,
                direction: Axis.vertical,
                center: Stack(
                  children: <Widget>[
                    AnimatedBackground(
                      behaviour: RandomParticleBehaviour(
                        options: ParticleOptions(
                          baseColor: Colors.white,
                          spawnMaxSpeed: 50,
                          spawnMinSpeed: 30,
                          particleCount: 20,
                        ),
                      ),
                      vsync: this,
                      child: Center(),
                    ),
                    Center(
                      child: Text(
                        'CURRENT VALUE',
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addDrink(BuildContext ctx) async {
    final newDrink = await showDialog(
      context: ctx,
      builder: (ctx) {
        return AddDrinkPopup();
      },
    );

    if (newDrink != null) {
      final user =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      final name = user['name'];
      final userData = json.decode(prefs.get(name)) as Map<String, dynamic>;

      List<dynamic> drinks = userData['drinks'];
      drinks.add(newDrink);
      userData['drinks'] = drinks;
      prefs.setString(name, json.encode(userData));

      setState(() {});
    }
  }
}
