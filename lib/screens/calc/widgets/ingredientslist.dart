import 'dart:convert';
import 'ingredient.dart';
import 'package:flutter/material.dart';

/// Decode
// Map ingredientsList = jsonDecode(jsonString);
// var ingredient = Ingredient.fromJson(ingredientsList);

/// Encode
// String json = jsonEncoude(ingredient);

// import { ingredientsList } from '../data/ingredientsList.js';
// import { loadCalculator } from './view.js';

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

// dynamic getIngredients(firstLetter) {
//   String jsonData =
//       rootBundle.loadString('data/ingredientsList.json') as String;
//   Map ingredientsList = jsonDecode(jsonData);

//   print(jsonData);

//   return ingredientsList;
// }

// export function getIngredientInfo(ingredientName) {
//   let ingredientVolume, ingredientOunces, ingredientGrams;

//   const ingredient = ingredientsList.filter(ingredient => {
//     return ingredient.name === ingredientName;
//   });

//   return ingredient[0];
// }
