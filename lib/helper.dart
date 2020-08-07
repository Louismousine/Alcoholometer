import 'dart:convert';

import 'package:alcool_app/main.dart';

class Helper {
  static double getPourcentage(String name) {
    final userData = json.decode(prefs.get(name)) as Map<String, dynamic>;

    // Avec userData t'as toutes les informations sous cette forme :
    // {weight: 160, height: 170, isFemale: false, drinks: [{volume: 15.0, pourcentage: 15.0, time: 23:52}, {volume: 1.0, pourcentage: 1.0, time: 23:52}]}
    final weight = userData['weight'];
    final height = userData['height'];
    final isFemale = userData['isFemale'];
    final List<dynamic> drinks = userData['drinks'];

    // Tu peux jouer avec l'Array (entre autres delete les consommations qui sont trop loin dans le temps)
    // Pour avoir le current time, c'est TimeOfDay.now()
    // Je m'occuperai de set le current storage pour reflect les changements

    return 0.5;
  }
}
