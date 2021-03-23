import 'dart:convert';
import 'dart:io';

import 'package:pan_pal/screens/recipes/recipe.dart';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

// Recently Viewed
Future<File> get _recentsFile async {
  final path = await _localPath;
  return File('$path/recents.txt');
}

Future<File> writeRecents(String recents) async {
  final file = await _recentsFile;
  return file.writeAsString(recents);
}

Future<String> readRecents() async {
  try {
    final file = await _recentsFile;

    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    return 'Could not read file :(';
  }
}

// User Recipes
Future<File> get _recipesFile async {
  final path = await _localPath;
  return File('$path/recipes.txt');
}

Future<File> writeRecipes(String recipes) async {
  final file = await _recipesFile;
  return file.writeAsString(recipes);
}

Future<String> readRecipes() async {
  try {
    final file = await _recipesFile;

    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    return 'Could not read file :(';
  }
}

void updateLocalRecipeCache(List<dynamic> recipeData) {
  //writeRecipes('');
  Map<String, dynamic> newRecipes = {};
  for (var item in recipeData) {
    String recipeId = item.documentID;

    newRecipes[recipeId] = Recipe.fromJson(item.data());
  }

  readRecipes().then((String data) {
    Map<String, dynamic> recipesToCache = {};

    if (data.length > 0 && data != 'Could not read file :(') {
      Map<String, dynamic> decodedData = jsonDecode(data);

      for (var item in decodedData.entries) {
        recipesToCache[item.key] = Recipe.fromJson(item.value);
      }
    }

    for (var entry in newRecipes.entries) {
      if (!recipesToCache.keys.contains(entry.key)) {
        recipesToCache[entry.key] = entry.value;

        Map<String, dynamic> recipesToCacheJson = {};
        for (var item in recipesToCache.entries) {
          recipesToCacheJson[item.key] = item.value;
        }

        writeRecipes(jsonEncode(recipesToCacheJson));
      }
    }
  });
}
