import 'dart:convert';
import 'package:pan_pal/screens/ingredients/ingredient.dart';

import 'package:flutter/material.dart';

class IngredientsList {
  List<dynamic> list;

  IngredientsList(BuildContext context, String jsonFilename) {
    this.list = List();

    initializeIngredientsList(context, jsonFilename);
  }

  IngredientsList.fromList(var list) {
    this.list = List();

    for (var item in list) {
      this.list.add(Ingredient(
          item['name'], item['volume'], item['ounces'], item['grams']));
    }
  }

  void initializeIngredientsList(
      BuildContext context, String jsonFilename) async {
    String jsonData =
        await DefaultAssetBundle.of(context).loadString(jsonFilename);
    list = jsonDecode(jsonData);
  }

  Ingredient getIngredient(String ingredientName) {
    return list.firstWhere((item) => item.name == ingredientName);
  }
}
