import 'package:pan_pal/screens/auth/auth.dart';
import 'package:pan_pal/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );

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

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _navigateToAuthScreen(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Navigator.of(context).pushReplacement(AuthScreen.route),
    );
  }

  void _navigateToHome(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Navigator.of(context).pushReplacement(Home.route),
    );
  }
}
