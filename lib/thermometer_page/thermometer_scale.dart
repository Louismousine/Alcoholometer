import 'package:flutter/material.dart';

class ThermometerScale extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaleWidth = MediaQuery.of(context).size.width / 13;
    final scaleHeight = MediaQuery.of(context).size.width / 100;
    final scaleUnit = 10.8;

    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 1.75,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.83,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  color: Colors.black,
                  height: scaleHeight,
                  width: scaleWidth,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '0.20',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 5 * scaleUnit,
            ),
            Row(
              children: <Widget>[
                Container(
                  color: Colors.black,
                  height: scaleHeight,
                  width: scaleWidth,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '0.15',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 3 * scaleUnit,
            ),
            Row(
              children: <Widget>[
                Container(
                  color: Colors.black,
                  height: scaleHeight,
                  width: scaleWidth,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '0.12',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 4 * scaleUnit,
            ),
            Row(
              children: <Widget>[
                Container(
                  color: Colors.black,
                  height: scaleHeight,
                  width: scaleWidth,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '0.08',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 3 * scaleUnit,
            ),
            Row(
              children: <Widget>[
                Container(
                  color: Colors.black,
                  height: scaleHeight,
                  width: scaleWidth,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '0.05',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 3 * scaleUnit,
            ),
            Row(
              children: <Widget>[
                Container(
                  color: Colors.black,
                  height: scaleHeight,
                  width: scaleWidth,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '0.02',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 2 * scaleUnit,
            ),
          ],
        ),
      ),
    );
  }
}
