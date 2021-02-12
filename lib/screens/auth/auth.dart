import 'package:animations/animations.dart';
import 'package:pan_pal/screens/auth/register.dart';
import 'package:pan_pal/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

import 'sign_in.dart';

class AuthScreen extends StatefulWidget {
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      );

  const AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LitAuth.custom(
      onAuthSuccess: () {
        Navigator.of(context).pushReplacement(Home.route);
      },
      child: Stack(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800),
              child: ValueListenableBuilder<bool>(
                  valueListenable: showSignInPage,
                  builder: (context, value, child) {
                    return PageTransitionSwitcher(
                      reverse: !value,
                      duration: Duration(milliseconds: 800),
                      transitionBuilder:
                          (child, animation, secondaryAnimation) {
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
                  }),
            ),
          ),
        ],
      ),
    ));
  }
}
