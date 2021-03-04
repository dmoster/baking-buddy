import 'package:pan_pal/screens/ingredients/ingredient.dart';

class Recipe {
  Recipe(this.name, this.imageUrl, this.ingredients, this.instructions,
      this.notes, this.story);

  String name;
  String imageUrl;
  List<Ingredient> ingredients;
  List<String> instructions;
  String notes;
  String story;
}
