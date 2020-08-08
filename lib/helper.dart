import 'package:alcool_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper {
  static const double ALCOHOL_DENSITY = 0.789;
  static const double BAC_REDUCTION = 0.015;
  static double getPourcentage(User user) {
    var totalAlcoholIngested = 0.0;
    final now = new DateTime.now();
    var firstTimeAtWhichDrinkWasTaken = now;
    user.drinks.forEach((drink) {
      if (drink.valid && drink.time.isBefore(now)) {
        totalAlcoholIngested +=
            drink.pourcentage * drink.volume * ALCOHOL_DENSITY;
        firstTimeAtWhichDrinkWasTaken =
            drink.time.isBefore(firstTimeAtWhichDrinkWasTaken)
                ? drink.time
                : firstTimeAtWhichDrinkWasTaken;
      }
    });
    var bloodVolume = user.isFemale
        ? 0.3561 * user.height * user.height * user.height / 1000000 +
            0.03308 * user.weight * 0.453592 +
            0.1833
        : 0.3669 * user.height * user.height * user.height / 1000000 +
            0.03219 * 0.453592 * user.weight +
            0.6041;
    var timeDiff = now.difference(firstTimeAtWhichDrinkWasTaken);
    var alcoholRemovedByLiver = timeDiff.inHours * BAC_REDUCTION +
        timeDiff.inMinutes * BAC_REDUCTION / 60;
    var bac = totalAlcoholIngested / (bloodVolume * 100) - alcoholRemovedByLiver;
    if (bac <= 0) {
      invalidatePastDrinks(user);
      return 0;
    }
    return double.parse(bac.toStringAsFixed(3));
  }

  static void invalidatePastDrinks(User user) {
    user.drinks.forEach(
      (drink) {
        drink.valid = false;
      },
    );
  }

  static double percentageToDisplayOnThermometer(double bac){
    const OFFSET = 0.29;
    const TOP_VALUE = 0.21;
    return OFFSET + bac * (1 - OFFSET) / TOP_VALUE;
  }

  static String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.Hm();
    return format.format(dt);
  }
}
