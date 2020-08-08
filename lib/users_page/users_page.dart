import 'package:alcool_app/providers/users.dart';
import 'package:alcool_app/top_bar.dart';
import 'package:alcool_app/users_page/user_list_item.dart';
import 'package:flutter/material.dart';
import 'package:alcool_app/add_user_popup.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users>(context).users;

    return Scaffold(
      floatingActionButton: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.amber,
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
          ListView.builder(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 3,
              left: 15,
              right: 15,
            ),
            itemBuilder: (ctx, index) {
              return UserListItem(users[index]);
            },
            itemCount: users.length,
          ),
        ],
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
