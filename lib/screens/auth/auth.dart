import 'package:animations/animations.dart';
import 'package:pan_pal/routes.dart';
import 'package:pan_pal/screens/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:pan_pal/screens/home_authenticated.dart';
import 'package:pan_pal/screens/ingredients/ingredientslist.dart';

import 'sign_in.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key, @required this.ingredients}) : super(key: key);

  final IngredientsList ingredients;

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LitAuth.custom(
        onAuthSuccess: () {
          Navigator.pushReplacementNamed(
            context,
            HomeAuthenticated.routeName,
            arguments: HomeAuthenticatedArguments(widget.ingredients, []),
          );
        },
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800),
            child: ValueListenableBuilder<bool>(
              valueListenable: showSignInPage,
              builder: (context, value, child) {
                return PageTransitionSwitcher(
                  reverse: !value,
                  duration: Duration(milliseconds: 800),
                  transitionBuilder: (child, animation, secondaryAnimation) {
                    return SharedAxisTransition(
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: SharedAxisTransitionType.vertical,
                      fillColor: Colors.transparent,
                      child: child,
                    );
                  },
                  child: value
                      ? SignIn(
                          key: ValueKey('SignIn'),
                          onRegisterClicked: () {
                            context.resetSignInForm();
                            showSignInPage.value = false;
                          },
                        )
                      : Register(
                          key: ValueKey('Register'),
                          onSignInPressed: () {
                            context.resetSignInForm();
                            showSignInPage.value = true;
                          },
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
