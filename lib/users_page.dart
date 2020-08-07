import 'dart:convert';

import 'package:alcool_app/main.dart';
import 'package:flutter/material.dart';
import 'package:alcool_app/add_user_popup.dart';
import 'package:alcool_app/thermometer_page.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    prefs.getKeys().forEach((element) {
      users.add({
        'name': element,
        'weight': json.decode(prefs.get(element))['weight'],
        'height': json.decode(prefs.get(element))['height'],
        'isFemale': json.decode(prefs.get(element))['isFemale'],
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.pink,
        child: IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => addUser(context),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          itemCount: getUsersLength(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (ctx, index) {
            return InkWell(
              splashColor: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15),
              onTap: () => {
                Navigator.of(context).pushNamed(ThermometerPage.routeName,
                    arguments: users[index])
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    users[index]['name'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  int getUsersLength() {
    return prefs.getKeys().length;
  }

  void addUser(BuildContext ctx) async {
    final newUser = await showDialog(
      context: ctx,
      builder: (ctx) {
        return AddUserPopup();
      },
    );

    if (newUser != null) {
      final userData = json.encode(
        {
          'weight': newUser['weight'],
          'height': newUser['height'],
          'isFemale': newUser['isFemale'],
          'drinks': []
        },
      );
      prefs.setString(newUser['name'], userData);
      users.add({
        'name': newUser['name'],
        'weight': newUser['weight'],
        'height': newUser['height'],
        'isFemale': newUser['isFemale'],
      });
      setState(() {});
    }
  }
}
