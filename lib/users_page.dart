import 'dart:convert';

import 'package:alcool_app/providers/users.dart';
import 'package:flutter/material.dart';
import 'package:alcool_app/add_user_popup.dart';
import 'package:alcool_app/thermometer_page.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users>(context).users;

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
          itemCount: users.length,
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
                Navigator.of(context).pushNamed(
                  ThermometerPage.routeName,
                  arguments: users[index],
                )
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    users[index].name,
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

  void addUser(BuildContext ctx) async {
    final newUser = await showDialog(
      context: ctx,
      builder: (ctx) {
        return AddUserPopup();
      },
    );

    if (newUser != null) {
      Provider.of<Users>(ctx, listen: false).addUser(
        name: newUser['name'],
        weight: newUser['weight'],
        height: newUser['height'],
        isFemale: newUser['isFemale'],
      );
    }
  }
}
