import 'package:flutter/material.dart';

class AddUserPopup extends StatefulWidget {
  @override
  _AddUserPopupState createState() => _AddUserPopupState();
}

class _AddUserPopupState extends State<AddUserPopup> {
  TextEditingController _name;
  TextEditingController _weight;
  TextEditingController _height;
  bool _isFemale = false;

  @override
  void initState() {
    _name = TextEditingController();
    _weight = TextEditingController();
    _height = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _weight.dispose();
    _height.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Add a new user'),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height / 4,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Name',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                  ),
                ),
                cursorColor: Colors.pink,
                expands: false,
                controller: _name,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Weight in lbs',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                  ),
                ),
                cursorColor: Colors.pink,
                expands: false,
                controller: _weight,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Height in cm',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                  ),
                ),
                cursorColor: Colors.pink,
                expands: false,
                controller: _height,
              ),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Male'),
                    Switch(
                      activeColor: Colors.pink,
                      value: _isFemale,
                      onChanged: (value) {
                        setState(() {
                          _isFemale = value;
                        });
                      },
                    ),
                    Text('Female')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            final data = {
              'name': _name.text,
              'weight': int.parse(_weight.text),
              'height': int.parse(_height.text),
              'isFemale': _isFemale
            };
            Navigator.of(context).pop(data);
          },
          child: Text(
            'Add user',
            style: TextStyle(
              color: Colors.pink,
            ),
          ),
        ),
      ],
    );
  }
}
