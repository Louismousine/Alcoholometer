import 'package:alcool_app/helper.dart';
import 'package:alcool_app/model/drink.dart';
import 'package:alcool_app/model/user.dart';
import 'package:alcool_app/new_drink_modal.dart';
import 'package:alcool_app/providers/users.dart';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';

class ThermometerPage extends StatefulWidget {
  static const routeName = '/thermometer';

  @override
  _ThermometerPageState createState() => _ThermometerPageState();
}

class _ThermometerPageState extends State<ThermometerPage>
    with TickerProviderStateMixin {
  TextEditingController _volume;
  TextEditingController _pourcentage;

  @override
  void initState() {
    _volume = TextEditingController();
    _pourcentage = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _volume.dispose();
    _pourcentage.dispose();

    super.dispose();
  }

  void _addNewDrink(BuildContext context) async {
    final newDrink = await showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewDrinkModal(),
          behavior: HitTestBehavior.opaque,
        );
      },
    ) as Drink;

    Provider.of<Users>(context, listen: false).addDrinkToUser(
      (ModalRoute.of(context).settings.arguments as User).id,
      newDrink,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context).settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.pink,
        ),
        title: Text(
          user.name,
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Add history popup here
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 30,
          bottom: MediaQuery.of(context).size.height / 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LiquidCustomProgressIndicator(
              value: Helper.getPourcentage(user),
              valueColor: AlwaysStoppedAnimation(
                Colors.pink,
              ),
              backgroundColor: Colors.white,
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
              shapePath: _buildThermometerPath(MediaQuery.of(context).size),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
        onPressed: () => _addNewDrink(context),
      ),
    );
  }

  Path _buildThermometerPath(size) {
    // Here goes the path
    var path = Path();
    path.lineTo(0,30);
    path.lineTo(15,30);
    path.lineTo(0, 50);
    path.close();
    return path;
  }
}
