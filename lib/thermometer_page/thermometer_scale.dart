import 'package:flutter/material.dart';
import 'package:alcool_app/bac_explanation.dart';

class ThermometerScale extends StatelessWidget {
  String getSideEffectsList(List<String> list) {
    String acc = '';
    list.forEach((effect) {
      acc += '\n• ' + effect + '\n';
    });
    return acc;
  }

  Widget buildScaleBar(
      {BuildContext context,
      double scaleWidth,
      double scaleHeight,
      String value}) {
    return Row(
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
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: Icon(Icons.more_horiz),
          onPressed: () {
            return showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text(
                    'Side effects when reaching $value g/mL',
                    textAlign: TextAlign.center,
                  ),
                  content: Text(
                    getSideEffectsList(
                      BacExplanation.getBacExplanations(value),
                    ),
                  ),
                );
              },
            );
          },
          color: Colors.pink,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaleWidth = MediaQuery.of(context).size.width / 13;
    final scaleHeight = MediaQuery.of(context).size.width / 100;
    final scaleUnit = 5.0;

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
            buildScaleBar(
              context: context,
              scaleWidth: scaleWidth,
              scaleHeight: scaleHeight,
              value: '0.20',
            ),
            SizedBox(
              height: 5 * scaleUnit,
            ),
            buildScaleBar(
              context: context,
              scaleWidth: scaleWidth,
              scaleHeight: scaleHeight,
              value: '0.15',
            ),
            SizedBox(
              height: 3 * scaleUnit,
            ),
            buildScaleBar(
              context: context,
              scaleWidth: scaleWidth,
              scaleHeight: scaleHeight,
              value: '0.12',
            ),
            SizedBox(
              height: 4 * scaleUnit,
            ),
            buildScaleBar(
              context: context,
              scaleWidth: scaleWidth,
              scaleHeight: scaleHeight,
              value: '0.08',
            ),
            SizedBox(
              height: 3 * scaleUnit,
            ),
            buildScaleBar(
              context: context,
              scaleWidth: scaleWidth,
              scaleHeight: scaleHeight,
              value: '0.05',
            ),
            SizedBox(
              height: 3 * scaleUnit,
            ),
            buildScaleBar(
              context: context,
              scaleWidth: scaleWidth,
              scaleHeight: scaleHeight,
              value: '0.02',
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
