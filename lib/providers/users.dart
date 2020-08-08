import 'dart:convert';

import 'package:alcool_app/main.dart';
import 'package:alcool_app/model/drink.dart';
import 'package:alcool_app/model/user.dart';
import 'package:flutter/cupertino.dart';

class Users with ChangeNotifier {
  static List<User> _users;

  List<User> get users {
    if (_users == null) {
      _users = [];
      prefs.getKeys().forEach(
        (element) {
          _users.add(
            User(
              id: element,
              name: json.decode(prefs.get(element))['name'],
              weight: json.decode(prefs.get(element))['weight'],
              height: json.decode(prefs.get(element))['height'],
              isFemale: json.decode(prefs.get(element))['isFemale'],
              drinks: jsonToDrinks(json.decode(prefs.get(element))['drinks']),
            ),
          );
        },
      );
      return [..._users];
    } else {
      return [..._users];
    }
  }

  void addUser({String name, double weight, double height, bool isFemale}) {
    final id = UniqueKey().toString();
    _users.add(
      User(
        id: id,
        name: name,
        weight: weight,
        height: height,
        isFemale: isFemale,
        drinks: [],
      ),
    );
    notifyListeners();
    final userData = json.encode(
      {
        'name': name,
        'weight': weight,
        'height': height,
        'isFemale': isFemale,
        'drinks': []
      },
    );
    prefs.setString(id, userData);
  }

  void deleteUser({String id}) {
    _users.removeWhere((u) => u.id == id);
    prefs.remove(id);
    notifyListeners();
  }

  void editUser(
      {String id, String name, double weight, double height, bool isFemale}) {
    final user = _users.firstWhere((user) => user.id == id);
    user.name = name;
    user.weight = weight;
    user.height = height;
    user.isFemale = isFemale;
    notifyListeners();

    final userData = json.encode(
      {
        'name': name,
        'weight': weight,
        'height': height,
        'isFemale': isFemale,
        'drinks':
            ((json.decode(prefs.get(id)) as Map<String, dynamic>)['drinks'])
      },
    );
    prefs.setString(id, userData);
  }

  void addDrinkToUser(String id, Drink drink) {
    _users.firstWhere((user) => user.id == id).drinks.add(drink);
    notifyListeners();

    final userData = json.decode(prefs.get(id)) as Map<String, dynamic>;

    List<dynamic> drinks = userData['drinks'];
    drinks.add({
      'id': drink.id,
      'volume': drink.volume,
      'pourcentage': drink.pourcentage,
      'time': drink.time.toString(),
    });
    userData['drinks'] = drinks;
    prefs.setString(id, json.encode(userData));
  }

  List<Drink> jsonToDrinks(List<dynamic> jsonDrinks) {
    List<Drink> drinks = [];
    jsonDrinks.forEach((drink) {
      drinks.add(
        Drink(
          id: drink['id'],
          volume: drink['volume'],
          pourcentage: drink['pourcentage'],
          time: DateTime.parse(drink['time']),
        ),
      );
    });
    return drinks;
  }
}
