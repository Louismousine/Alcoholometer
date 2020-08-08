import 'package:alcool_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper {
  static const double ALCOHOL_DENSITY = 0.789;
  static const double BAC_REDUCTION = 0.015;
  static const OFFSET = 0.29;
  static const TOP_VALUE = 0.21;
  static const firstScalePercentage = OFFSET + 0.02 * (1 - OFFSET) / TOP_VALUE;
  static const secondScalePercentage = OFFSET + 0.05 * (1 - OFFSET) / TOP_VALUE;
  static const thirdScalePercentage = OFFSET + 0.08 * (1 - OFFSET) / TOP_VALUE;
  static const fourthScalePercentage = OFFSET + 0.12 * (1 - OFFSET) / TOP_VALUE;
  static const fifthScalePercentage = OFFSET + 0.15 * (1 - OFFSET) / TOP_VALUE;

  static double getPourcentage(User user) {
    final double height = user.height / 100;
    final double weight = user.weight * 0.453592;

    var totalAlcoholIngested = 0.0;
    final now = new DateTime.now();
    var firstTimeAtWhichDrinkWasTaken = now;
    user.drinks.forEach((drink) {
      if (drink.valid && drink.time.isBefore(now)) {
        totalAlcoholIngested +=
            drink.pourcentage / 100 * drink.volume * ALCOHOL_DENSITY;
        firstTimeAtWhichDrinkWasTaken =
            drink.time.isBefore(firstTimeAtWhichDrinkWasTaken)
                ? drink.time
                : firstTimeAtWhichDrinkWasTaken;
      }
    });
    final bloodVolume = user.isFemale
        ? 0.3561 * height * height * height + 0.03308 * weight + 0.1833
        : 0.3669 * height * height * height + 0.03219 * weight + 0.6041;
    var timeDiff = now.difference(firstTimeAtWhichDrinkWasTaken);
    var alcoholRemovedByLiver = timeDiff.inHours * BAC_REDUCTION +
        timeDiff.inMinutes * BAC_REDUCTION / 60.0;
    var bac =
        totalAlcoholIngested / (bloodVolume * 100) - alcoholRemovedByLiver;
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

  static double percentageToDisplayOnThermometer(double bac) {
    return OFFSET + bac * (1 - OFFSET) / TOP_VALUE;
  }

  static Color hexColorForPercentage(double percentage) {
    if (percentage < firstScalePercentage) {
      return Color(0xFF868A46);
    }
    if (percentage < secondScalePercentage) {
      return Color(0xFF997E44);
    }
    if (percentage < thirdScalePercentage) {
      return Color(0xFFAC7242);
    }
    if (percentage < fourthScalePercentage) {
      return Color(0xFFC0653D);
    }
    if (percentage < fifthScalePercentage) {
      return Color(0xFFD3593B);
    }
    return Color(0xFFEC4838);
  }

  static double alcoholIntakeLastWeek(User user) {
    final now = new DateTime.now();
    final weekAgo = now.subtract(new Duration(days: 7));
    double intake = 0;
    user.drinks.forEach((drink) {
      if (drink.time.isAfter(weekAgo)) {
        intake += drink.pourcentage / 100 * drink.volume * ALCOHOL_DENSITY;
      }
    });
    return intake;
  }

  static String timeUntilSober(double bac) {
    if(bac == 0.0) {
      return '';
    }
    int hours = (bac / BAC_REDUCTION).round();
    double bacLeft = bac % BAC_REDUCTION;
    int minutes = (bacLeft / (BAC_REDUCTION / 60.0)).round();
    var now = new DateTime.now();
    now = now.add(new Duration(hours: hours, minutes: minutes));
    return 'Will be sober around ' + now.hour.toString() + ':' + now.minute.toString();
  }

  static String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.Hm();
    return format.format(dt);
  }
}
