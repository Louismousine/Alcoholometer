import 'package:alcool_app/model/drink.dart';
import 'package:flutter/material.dart';

class NewDrinkModal extends StatefulWidget {
  @override
  _NewDrinkModalState createState() => _NewDrinkModalState();
}

class _NewDrinkModalState extends State<NewDrinkModal> {
  final _volumeController = TextEditingController();
  final _pourcentageController = TextEditingController();
  DateTime _selectedTime = DateTime.now();

  @override
  void dispose() {
    _volumeController.dispose();
    _pourcentageController.dispose();
    super.dispose();
  }

  void _submitData() {
    final enteredVolume = double.parse(_volumeController.text);
    final enteredPourcentage = double.parse(_pourcentageController.text);
    final enteredTime = _selectedTime;

    Navigator.of(context).pop(
      Drink(
        id: UniqueKey().toString(),
        pourcentage: enteredPourcentage,
        volume: enteredVolume,
        time: enteredTime,
        valid: true,
      ),
    );
  }

  void _presentDatePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(primarySwatch: Colors.pink),
          child: child,
        );
      },
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        _selectedTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 10,
      ),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Volume (mL)',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink),
                      ),
                    ),
                    cursorColor: Colors.pink,
                    expands: false,
                    controller: _volumeController,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Alcool %',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink),
                      ),
                    ),
                    cursorColor: Colors.pink,
                    expands: false,
                    controller: _pourcentageController,
                  ),
                ),
              ],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _selectedTime.hour.toString() +
                        ':' +
                        _selectedTime.minute.toString(),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.access_time,
                      color: Colors.pink,
                    ),
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: _submitData,
                  backgroundColor: Colors.pink,
                  mini: true,
                  elevation: 0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
