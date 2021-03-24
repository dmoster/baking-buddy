import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pan_pal/screens/recipes/recipe.dart';

class RecipeList {
  List<dynamic> list;

  RecipeList(BuildContext context, String jsonFilename) {
    this.list = [];

    initializeRecipeList(context, jsonFilename);
  }

  RecipeList.fromList(var list) {
    this.list = [];

    for (var item in list) {
      this.list.add(Recipe(
          item['name'],
          item['author'],
          item['category'],
          item['imageUrl'],
          item['ingredients'],
          item['instructions'],
          item['notes'],
          item['story']));
    }
  }

  void initializeRecipeList(BuildContext context, String jsonFilename) async {
    String jsonData =
        await DefaultAssetBundle.of(context).loadString(jsonFilename);
    list = jsonDecode(jsonData);
  }

  Recipe getRecipe(String recipeName) {
    return list.firstWhere((item) => item.name == recipeName);
  }
}
