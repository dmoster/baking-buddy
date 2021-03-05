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
