import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:pan_pal/routes.dart';
import 'package:pan_pal/screens/dashboard/alphabet_search.dart';
import 'package:pan_pal/screens/dashboard/recently_viewed.dart';
import 'package:pan_pal/screens/home_unauthenticated.dart';
import 'package:pan_pal/screens/ingredients/ingredientslist.dart';
import 'package:pan_pal/screens/recipes/recipe_browser.dart';
import 'package:pan_pal/screens/recipes/recipe_composer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key key,
    this.context,
    @required this.onSearchIngredients,
    @required this.onSearchRecipes,
    @required this.recentlyViewed,
    @required this.ingredients,
  }) : super(key: key);

  final Function(List) onSearchIngredients;
  final Function(String) onSearchRecipes;
  final List<dynamic> recentlyViewed;
  final IngredientsList ingredients;
  final BuildContext context;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<bool> _selections = [false, true];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: RecentlyViewed(
              context: context,
              recentlyViewed: widget.recentlyViewed,
              ingredients: widget.ingredients,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                AlphabetSearch(
                  context: context,
                  onSearch: (String searchLetter) {
                    if (_selections[0] == true) {
                      List ingredientsList = [];

                      for (var ingredient in widget.ingredients.list) {
                        if (ingredient.name.startsWith(searchLetter)) {
                          ingredientsList.add(ingredient);
                        }
                      }

                      widget.onSearchIngredients(ingredientsList);
                    } else {
                      widget.onSearchRecipes(searchLetter);
                    }
                  },
                ),
                SizedBox(height: 16),
                ToggleButtons(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Ingredients',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Recipes',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                  isSelected: _selections,
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < _selections.length; i++) {
                        if (i == index) {
                          _selections[i] = true;
                        } else {
                          _selections[i] = false;
                        }
                      }
                    });
                  },
                  borderRadius: BorderRadius.circular(5),
                  borderWidth: 2,
                  borderColor: Color(0xFFFF9F00),
                  color: Color(0xFFFF9F00),
                  fillColor: Color(0xFFFF9F00),
                  selectedColor: Color(0xff323232),
                  selectedBorderColor: Color(0xFFFF9F00),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  tooltip: 'Sign Out',
                  onPressed: () {
                    context.signOut();
                    Navigator.pushReplacementNamed(
                      context,
                      HomeUnauthenticated.routeName,
                      arguments: IngredientPageArguments(widget.ingredients),
                    );
                  },
                ),
                RawMaterialButton(
                  elevation: 1.0,
                  fillColor: Color(0xff0f4fa8),
                  splashColor: Colors.orange,
                  padding: const EdgeInsets.all(16.0),
                  shape: const CircleBorder(),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: () async {
                    await Navigator.pushNamed(
                      context,
                      RecipeComposer.routeName,
                      arguments: RecipeComposerArguments(
                        widget.ingredients,
                        widget.recentlyViewed,
                      ),
                    );
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.list_alt_outlined,
                    color: Colors.white,
                  ),
                  tooltip: 'Recipe Browser',
                  onPressed: () async {
                    await Navigator.pushNamed(
                      context,
                      RecipeBrowser.routeName,
                      arguments: RecipeBrowserArguments(
                        widget.recentlyViewed,
                        '',
                      ),
                    );
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
