import 'dart:convert';

import 'package:alcool_app/users_page.dart';
import 'package:alcool_app/thermometer_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();
  prefs.clear();
  prefs.setString(
      'William',
      json.encode(
          {'weight': 120, 'height': 167, 'isFemale': false, 'drinks': []}));
  prefs.setString(
      'Louis',
      json.encode(
          {'weight': 140, 'height': 190, 'isFemale': false, 'drinks': []}));
  prefs.setString(
      'Jé Mark',
      json.encode(
          {'weight': 160, 'height': 170, 'isFemale': false, 'drinks': []}));
  prefs.setString(
      'Mich',
      json.encode(
          {'weight': 160, 'height': 170, 'isFemale': false, 'drinks': []}));
  prefs.setString(
      'Isaac',
      json.encode(
          {'weight': 180, 'height': 190, 'isFemale': false, 'drinks': []}));
  prefs.setString(
      'Jed',
      json.encode(
          {'weight': 150, 'height': 170, 'isFemale': false, 'drinks': []}));
  prefs.setString(
      'Clarissa',
      json.encode(
          {'weight': 120, 'height': 160, 'isFemale': true, 'drinks': []}));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UsersPage(),
      routes: {
        ThermometerPage.routeName: (ctx) => ThermometerPage(),
      },
    );
  }
}
