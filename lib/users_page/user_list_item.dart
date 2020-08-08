import 'package:alcool_app/model/user.dart';
import 'package:alcool_app/providers/users.dart';
import 'package:alcool_app/thermometer_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListItem extends StatelessWidget {
  final User user;

  UserListItem(this.user);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(user.id),
      background: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Colors.red,
          child: Container(
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
              left: 20,
            ),
          ),
          elevation: 0,
        ),
      ),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (dir) {
        return showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                'Are you sure you want to delete this user ?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        Provider.of<Users>(context, listen: false)
            .deleteUser(id: user.id);
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'User was successfully deleted',
              textAlign: TextAlign.center,
            ),
            duration: Duration(seconds: 3),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Colors.white,
          child: ListTile(
            onTap: () => {
              Navigator.of(context).pushNamed(
                ThermometerPage.routeName,
                arguments: user,
              )
            },
            title: Text(user.name),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
