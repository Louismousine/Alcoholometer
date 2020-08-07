import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddDrinkPopup extends StatefulWidget {
  @override
  _AddDrinkPopupState createState() => _AddDrinkPopupState();
}

class _AddDrinkPopupState extends State<AddDrinkPopup> {
  TextEditingController _volume;
  TextEditingController _pourcentage;
  TimeOfDay _time = TimeOfDay.now();

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

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.Hm();
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Add a new user'),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height / 5,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Alcool volume in mL',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                  ),
                ),
                cursorColor: Colors.pink,
                expands: false,
                controller: _volume,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Alcool %',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                  ),
                ),
                cursorColor: Colors.pink,
                expands: false,
                controller: _pourcentage,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(formatTimeOfDay(_time)),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                    iconSize: 20,
                    onPressed: () async {
                      TimeOfDay time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (BuildContext context, Widget child) {
                          return Theme(
                            data: ThemeData(primarySwatch: Colors.pink),
                            child: child,
                          );
                        },
                      );
                      if (time != null) {
                        setState(() {
                          _time = time;
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            final data = {
              'volume': double.parse(_volume.text),
              'pourcentage': double.parse(_pourcentage.text),
              'time': formatTimeOfDay(_time),
            };
            Navigator.of(context).pop(data);
          },
          child: Text(
            'Add drink',
            style: TextStyle(
              color: Colors.pink,
            ),
          ),
        ),
      ],
    );
  }
}
