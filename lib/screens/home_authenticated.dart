import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:pan_pal/screens/calc/calculator.dart';
import 'package:pan_pal/screens/dashboard/dashboard.dart';
import 'package:pan_pal/screens/ingredients/ingredientslist.dart';

class HomeAuthenticated extends StatelessWidget {
  const HomeAuthenticated({
    Key key,
    @required this.ingredients,
  }) : super(key: key);

  final IngredientsList ingredients;

  static const routeName = '/home_authenticated';

  @override
  Widget build(BuildContext context) {
    IngredientsList calculatorIngredients =
        IngredientsList.fromIngredientList(ingredients.list);

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
              toolbarHeight: 32,
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
                    Icons.arrow_back_ios,
                    size: 16,
                    color: Colors.white,
                  ),
                  onPressed: () => goBack(),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.white,
                  ),
                  onPressed: () => goForward(),
                ),
              ],
            ),
            body: PageView(
              controller: pageController,
              children: [
                Calculator(
                  ingredients: calculatorIngredients,
                ),
                Dashboard(
                  context: context,
                  ingredients: ingredients,
                  onSearch: (List filteredIngredients) {
                    calculatorIngredients.list = filteredIngredients;
                    goBack();
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
