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
  List<Recipe> newRecipes = recipeData.map((var item) {
    print(item.documentID);
    return Recipe.fromJson(item.data());
  }).toList();

  print('Reading recipes...');
  readRecipes().then((String data) {
    List<dynamic> recipesToCache = [];

    print('Checking for previously stored recipes...');
    if (data.length > 0 && data != 'Could not read file :(') {
      print('Recipes found!');
      recipesToCache = jsonDecode(data).map((var item) {
        return Recipe.fromJson(item);
      }).toList();
      print(recipesToCache[0].name);
    }

    for (var item in newRecipes) {
      print('Checking cache for ' + item.name + '...');
      if (!recipesToCache.contains(item)) {
        print('New recipe was not found!');
        print('Adding recipe...');
        recipesToCache.add(item);

        List<dynamic> recipesToCacheJson = recipesToCache.map((var item) {
          return item.toJson();
        }).toList();

        print('Updating local recipe cache...');
        writeRecipes(jsonEncode(recipesToCacheJson));
      } else {
        print('Recipe is already cached!');
      }
    }
  });
}
