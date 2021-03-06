import 'package:pan_pal/screens/ingredients/ingredient.dart';

class Recipe {
  Recipe(this.name, this.author, this.imageUrl, this.ingredients,
      this.instructions, this.notes, this.story);

  String name;
  String author;
  String imageUrl;
  List<Ingredient> ingredients;
  List<String> instructions;
  String notes;
  String story;

  Map<String, dynamic> toJson() {
    List<dynamic> ingredientsStrings = [];

    for (var item in ingredients) {
      ingredientsStrings.add(item.toJson());
    }

    return {
      'name': name,
      'author': author,
      'imageUrl': imageUrl,
      'ingredients': ingredientsStrings,
      'instructions': instructions,
      'notes': notes,
      'story': story,
    };
  }
}
