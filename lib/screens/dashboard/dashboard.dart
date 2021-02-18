import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:pan_pal/screens/auth/auth.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key, this.context}) : super(key: key);

  final BuildContext context;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              RaisedButton(
                onPressed: () {
                  context.signOut();
                  Navigator.of(context).pushReplacement(AuthScreen.route);
                },
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(),
        ),
        Expanded(
          flex: 4,
          child: Container(),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
      ],
    );
  }
}
