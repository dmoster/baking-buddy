import 'package:flutter/material.dart';
import 'package:pan_pal/screens/calc/converter.dart';
import 'package:pan_pal/screens/calc/formatNumbers.dart';
import 'package:pan_pal/screens/ingredients/ingredient_row_display.dart';

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
      this.name, this.amount, this.measurementType, this.refIngredient) {
    this.volume =
        getConvertedAmount(amount, measurementType, 'volume', refIngredient);
    this.ounces = formatNumber(getConvertedAmount(
            amount, measurementType, 'ounces', refIngredient)) +
        ' oz';
    this.grams = formatNumber(getConvertedAmount(
            amount, measurementType, 'grams', refIngredient)) +
        ' g';
  }

  Widget displayRow() {
    return IngredientRowDisplay(
        labelSize: 16,
        amount: this.amount,
        measurementType: this.measurementType,
        refIngredient: this.refIngredient);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> ingredientMap = {
      'name': name,
      'volume': volume,
      'ounces': ounces,
      'grams': grams,
      'amount': amount,
      'measurementType': measurementType,
      'refIngredient': null,
    };
    if (refIngredient != null) {
      ingredientMap['refIngredient'] = refIngredient.toJson();
    }
    return ingredientMap;
  }

  Ingredient.fromJson(Map parsedJson) {
    this.name = parsedJson['name'];
    this.volume = parsedJson['volume'];
    this.ounces = parsedJson['ounces'];
    this.grams = parsedJson['grams'];
    this.amount = parsedJson['amount'];
    this.measurementType = parsedJson['measurementType'];

    if (parsedJson['refIngredient'] != null) {
      this.refIngredient = Ingredient.fromJson(parsedJson['refIngredient']);
    }
  }
}
