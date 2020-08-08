import 'package:flutter/material.dart';

class Drink {
  String id;
  double pourcentage;
  double volume;
  DateTime time;
  boolean valid;

  Drink({this.id, this.pourcentage, this.time, this.volume, this.valid});
}
