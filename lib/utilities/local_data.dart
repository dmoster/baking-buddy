import 'dart:io';

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
