import 'package:flutter/material.dart';
import 'package:pan_pal/screens/auth/auth.dart';
import 'package:pan_pal/screens/calc/calculator.dart';
import 'package:pan_pal/screens/ingredients/ingredientslist.dart';

class HomeUnauthenticated extends StatelessWidget {
  const HomeUnauthenticated({Key key, @required this.ingredients})
      : super(key: key);

  final IngredientsList ingredients;

  static const routeName = '/home_unauthenticated';

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
    int pageChanged = 0;

    String pageName = 'Convert a Measurement';

    return Container(
      child: Stack(
        children: [
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/chocolate_bundt_cake-top_alt.jpg'),
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
          PageView(
            controller: pageController,
            children: [
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  toolbarHeight: 32,
                  centerTitle: false,
                  title: Text(
                    pageName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  actions: [
                    RaisedButton(
                      child: Text(
                        'My Baking Buddy',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Color(0xff0F4FA8),
                      padding: EdgeInsets.all(8),
                      onPressed: () {
                        pageController.animateToPage(
                          pageChanged == 1 ? 1 : ++pageChanged,
                          duration: Duration(milliseconds: 250),
                          curve: Curves.bounceInOut,
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ],
                ),
                body: Calculator(
                  ingredients: ingredients,
                ),
              ),
              AuthScreen(
                ingredients: ingredients,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
