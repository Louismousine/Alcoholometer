import 'dart:convert';

import 'package:alcool_app/providers/users.dart';
import 'package:alcool_app/users_page/users_page.dart';
import 'package:alcool_app/thermometer_page/thermometer_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();
  prefs.clear();
  prefs.setString(
      '1',
      json.encode({
        'name': 'William',
        'weight': 120.0,
        'height': 167.0,
        'isFemale': false,
        'drinks': []
      }));
  prefs.setString(
      '2',
      json.encode({
        'name': 'Louis',
        'weight': 140.0,
        'height': 190.0,
        'isFemale': false,
        'drinks': []
      }));
  prefs.setString(
      '3',
      json.encode({
        'name': 'Jé Mark',
        'weight': 160.0,
        'height': 170.0,
        'isFemale': false,
        'drinks': []
      }));
  prefs.setString(
      '4',
      json.encode({
        'name': 'Mich',
        'weight': 160.0,
        'height': 170.0,
        'isFemale': false,
        'drinks': []
      }));
  prefs.setString(
      '5',
      json.encode({
        'name': 'Isaac',
        'weight': 180.0,
        'height': 190.0,
        'isFemale': false,
        'drinks': []
      }));
  prefs.setString(
      '6',
      json.encode({
        'name': 'Jed',
        'weight': 150.0,
        'height': 170.0,
        'isFemale': false,
        'drinks': []
      }));
  prefs.setString(
      '7',
      json.encode({
        'name': 'Clarissa',
        'weight': 120.0,
        'height': 160.0,
        'isFemale': true,
        'drinks': []
      }));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Users(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Alcoholometer',
        home: UsersPage(),
        routes: {
          ThermometerPage.routeName: (ctx) => ThermometerPage(),
        },
        theme: ThemeData(
          primaryColor: Color(0xFF6B75D6),
        ),
      ),
    );
  }
}
