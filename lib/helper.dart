import 'dart:convert';

import 'package:alcool_app/main.dart';
import 'package:alcool_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper {
  static double getPourcentage(User user) {
    // Toutes les info via user.*

    return 0.5;
  }

  static String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.Hm();
    return format.format(dt);
  }
}
