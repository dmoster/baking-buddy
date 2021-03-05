import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:pan_pal/routes.dart';
import 'package:pan_pal/screens/home_authenticated.dart';
import 'package:pan_pal/screens/home_unauthenticated.dart';
import 'package:pan_pal/screens/ingredients/ingredientslist.dart';
import 'package:pan_pal/screens/welcome.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key, @required this.ingredients}) : super(key: key);

  final IngredientsList ingredients;

  static const routeName = '/splash_screen';

  @override
  Widget build(BuildContext context) {
    final user = context.watchSignedInUser();
    user.map(
      (value) {
        _navigateToHome(context);
      },
      empty: (_) {
        _navigateToAuthScreen(context);
      },
      initializing: (_) {},
    );

    return Scaffold(
      body: Welcome(),
    );
  }

  void _navigateToAuthScreen(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Navigator.pushReplacementNamed(
        context,
        HomeUnauthenticated.routeName,
        arguments: IngredientPageArguments(ingredients),
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Navigator.pushReplacementNamed(
        context,
        HomeAuthenticated.routeName,
        arguments: IngredientPageArguments(ingredients),
      ),
    );
  }
}
