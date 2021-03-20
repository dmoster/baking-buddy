import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:pan_pal/routes.dart';
import 'package:pan_pal/screens/calc/calculator.dart';
import 'package:pan_pal/screens/dashboard/dashboard.dart';
import 'package:pan_pal/screens/ingredients/ingredient.dart';
import 'package:pan_pal/screens/ingredients/ingredientslist.dart';
import 'package:pan_pal/screens/recipes/recipe_browser.dart';
import 'package:pan_pal/utilities/local_data.dart';
import 'package:pan_pal/screens/dashboard/recently_viewed.dart';

class HomeAuthenticated extends StatefulWidget {
  const HomeAuthenticated({
    Key key,
    @required this.recentlyViewed,
    @required this.ingredients,
  }) : super(key: key);

  final List<dynamic> recentlyViewed;
  final IngredientsList ingredients;

  static const routeName = '/home_authenticated';

  @override
  _HomeAuthenticatedState createState() => _HomeAuthenticatedState();
}

class _HomeAuthenticatedState extends State<HomeAuthenticated> {
  @override
  Widget build(BuildContext context) {
    IngredientsList calculatorIngredients =
        IngredientsList.fromIngredientList(widget.ingredients.list);

    final PageController pageController = PageController(
      initialPage: 1,
      keepPage: true,
    );
    int pageChanged = 0;

    void goBack() {
      pageController.animateToPage(
        pageChanged == 0 ? 0 : --pageChanged,
        duration: Duration(milliseconds: 250),
        curve: Curves.bounceInOut,
      );
    }

    void goForward() {
      pageController.animateToPage(
        pageChanged == 1 ? 1 : ++pageChanged,
        duration: Duration(milliseconds: 250),
        curve: Curves.bounceInOut,
      );
    }

    String pageName = 'Baking Buddy';

    return Container(
      child: Stack(
        children: [
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/glazed_donuts-top.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              toolbarHeight: 48,
              title: Text(
                pageName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.calculate_outlined,
                    color: Colors.white,
                  ),
                  tooltip: 'Ingredient Calculator',
                  onPressed: () => goBack(),
                ),
                IconButton(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
                  tooltip: 'Dashboard',
                  onPressed: () => goForward(),
                ),
              ],
            ),
            body: PageView(
              controller: pageController,
              children: [
                Calculator(
                  ingredients: calculatorIngredients,
                  onViewed: (Ingredient ingredient) {
                    widget.recentlyViewed.add(ingredient);
                    cleanRecents(widget.recentlyViewed);

                    List<dynamic> recentsJson = [];
                    recentsJson = widget.recentlyViewed.map((var item) {
                      return item.toJson();
                    }).toList();

                    writeRecents(jsonEncode(recentsJson));
                  },
                ),
                Dashboard(
                  context: context,
                  ingredients: widget.ingredients,
                  onSearchIngredients: (List filteredIngredients) {
                    calculatorIngredients.list = filteredIngredients;
                    goBack();
                  },
                  onSearchRecipes: (String searchLetter) async {
                    await Navigator.pushNamed(
                      context,
                      RecipeBrowser.routeName,
                      arguments: RecipeBrowserArguments(
                        widget.recentlyViewed,
                        searchLetter,
                      ),
                    );
                    setState(() {});
                  },
                  recentlyViewed: widget.recentlyViewed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
