import 'package:pan_pal/screens/calc/converter.dart';
import 'package:pan_pal/screens/calc/formatNumbers.dart';

class Ingredient {
  String name;
  dynamic volume;
  dynamic ounces;
  dynamic grams;
  double amount;
  String measurementType;
  Ingredient refIngredient;

  Ingredient(this.name, this.volume, this.ounces, this.grams);
  Ingredient.fromAmount(
      this.name, this.amount, this.measurementType, this.refIngredient);

  // Ingredient.fromAmount(String name, double amount, String measurementType,
  //     Ingredient refIngredient) {
  //   this.name = name;

  //   if (measurementType == 'cups' ||
  //       measurementType == 'tablespoons' ||
  //       measurementType == 'teaspoons') {
  //     this.volume = getVolumeInTsp(amount, measurementType);
  //     this.ounces = formatNumber(getConvertedAmount(
  //         this.volume, 'teaspoons', 'ounces', refIngredient));
  //     this.grams = formatNumber(
  //         getConvertedAmount(this.volume, 'teaspoons', 'grams', refIngredient));
  //   } else {
  //     this.volume =
  //         getVolumeInTsp(amount, measurementType, ingredient: refIngredient);
  //   }

  //   if (measurementType == 'ounces') {
  //     this.ounces = amount;
  //     this.grams = formatNumber(
  //         getConvertedAmount(this.ounces, 'ounces', 'grams', refIngredient));
  //   } else if (measurementType == 'grams') {
  //     this.grams = amount;
  //     this.ounces = formatNumber(
  //         getConvertedAmount(this.grams, 'grams', 'ounces', refIngredient));
  //   }
  // }
}
