import 'package:alcool_app/model/user.dart';
import 'package:flutter/material.dart';

class EditUserPopup extends StatefulWidget {
  final User user;

  EditUserPopup(this.user);

  @override
  _EditUserPopupState createState() => _EditUserPopupState();
}

class _EditUserPopupState extends State<EditUserPopup> {
  TextEditingController _name;
  TextEditingController _weight;
  TextEditingController _height;
  bool _isFemale;

  @override
  void initState() {
    _name = TextEditingController(text: widget.user.name);
    _weight = TextEditingController(text: widget.user.weight.toString());
    _height = TextEditingController(text: widget.user.height.toString());
    _isFemale = widget.user.isFemale;

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
        child: Text('Edit ${widget.user.name}'),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
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
              'weight': double.parse(_weight.text),
              'height': double.parse(_height.text),
              'isFemale': _isFemale
            };
            Navigator.of(context).pop(data);
          },
          child: Text(
            'Edit',
            style: TextStyle(
              color: Colors.pink,
            ),
          ),
        ),
      ],
    );
  }
}
