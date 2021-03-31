import 'package:pan_pal/screens/ingredients/ingredient.dart';

class Recipe {
  Recipe(this.name, this.author, this.category, this.imageUrl, this.ingredients,
      this.instructions, this.notes, this.story) {
    this.recipeId = 'recipe_' + DateTime.now().toString() + '-' + this.author;
  }

  String recipeId;
  String name;
  String author;
  String category;
  String imageUrl;
  List<Ingredient> ingredients;
  List<dynamic> instructions;
  String notes;
  String story;

  Map<String, dynamic> toJson() {
    List<dynamic> ingredientsStrings = [];

    for (var item in ingredients) {
      ingredientsStrings.add(item.toJson());
    }

    return {
      'recipeId': recipeId,
      'name': name,
      'author': author,
      'category': category,
      'imageUrl': imageUrl,
      'ingredients': ingredientsStrings,
      'instructions': instructions,
      'notes': notes,
      'story': story,
    };
  }

  Recipe.fromJson(Map parsedJson) {
    this.recipeId = parsedJson['recipeId'];
    this.name = parsedJson['name'];
    this.author = parsedJson['author'];
    this.category = parsedJson['category'];
    this.imageUrl = parsedJson['imageUrl'];
    this.ingredients = [];

    for (int i = 0; i < parsedJson['ingredients'].length; i++) {
      this.ingredients.add(Ingredient.fromJson(parsedJson['ingredients'][i]));
    }

    this.instructions = parsedJson['instructions'];
    this.notes = parsedJson['notes'];
    this.story = parsedJson['story'];
  }
}
