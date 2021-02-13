import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

import 'auth/auth.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const Home(),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   title: const Text(
        //     'My Pan Pal',
        //     style: TextStyle(
        //       fontSize: 16,
        //       color: Colors.white,
        //     ),
        //   ),
        //   foregroundColor: Colors.white,
        // ),
        body: Stack(children: [
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
                color: Colors.black38,
              ),
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                context.signOut();
                Navigator.of(context).push(AuthScreen.route);
              },
              child: const Text('Sign Out'),
            ),
          ),
        ]),
      ),
    );
  }
}
