import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:pan_pal/routes.dart';
import 'package:pan_pal/screens/dashboard/alphabet_search.dart';
import 'package:pan_pal/screens/dashboard/recently_viewed.dart';
import 'package:pan_pal/screens/home_unauthenticated.dart';
import 'package:pan_pal/screens/ingredients/ingredientslist.dart';
import 'package:pan_pal/screens/recipes/recipe_composer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key, this.context, @required this.ingredients})
      : super(key: key);

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
          SizedBox(height: 16),
          Expanded(
            flex: 4,
            child: RecentlyViewed(
              context: context,
              ingredients: widget.ingredients,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                AlphabetSearch(context: context),
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
                RaisedButton(
                  onPressed: () {
                    context.signOut();
                    Navigator.pushReplacementNamed(
                      context,
                      HomeUnauthenticated.routeName,
                      arguments: IngredientPageArguments(widget.ingredients),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Color(0xff0F4FA8),
                  child: const Text('Sign Out'),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RecipeComposer.routeName,
                      arguments: IngredientPageArguments(widget.ingredients),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Color(0xFFFFCA00),
                  child: const Text(
                    'Add Recipe',
                    style: TextStyle(
                      color: Color(0xff323232),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
