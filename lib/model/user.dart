import 'package:alcool_app/model/drink.dart';
class User {
  String id;
  String name;
  double height;
  double weight;
  bool isFemale;
  List<Drink> drinks;

  User({
    this.id,
    this.name,
    this.height,
    this.weight,
    this.isFemale,
    this.drinks,
  });
}
