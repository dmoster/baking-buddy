import 'package:pan_pal/screens/ingredients/ingredientslist.dart';
import 'package:pan_pal/screens/recipes/recipe.dart';

class IngredientPageArguments {
  final IngredientsList ingredients;

  IngredientPageArguments(this.ingredients);
}

class RecipePageArguments {
  final Recipe recipe;
  final String returnScreen;

  RecipePageArguments(this.recipe, this.returnScreen);
}
