import 'package:alcool_app/model/user.dart';
import 'package:alcool_app/providers/users.dart';
import 'package:alcool_app/users_page/edit_user_popup.dart';
import 'package:alcool_app/users_page/top_bar.dart';
import 'package:alcool_app/users_page/user_list_item.dart';
import 'package:flutter/material.dart';
import 'package:alcool_app/users_page/add_user_popup.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
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

  void editUser(BuildContext ctx, User user) async {
    final editUser = await showDialog(
      context: ctx,
      builder: (ctx) {
        return EditUserPopup(user);
      },
    );

    if (editUser != null) {
      Provider.of<Users>(ctx, listen: false).editUser(
        id: user.id,
        name: editUser['name'],
        weight: editUser['weight'],
        height: editUser['height'],
        isFemale: editUser['isFemale'],
      );
    }
  }

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
      body: Stack(
        children: <Widget>[
          TopBar(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 1.5,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 10,
                ),
                width: double.infinity,
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      return UserListItem(users[index], editUser);
                    },
                    itemCount: users.length,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
