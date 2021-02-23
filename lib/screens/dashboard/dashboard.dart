import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:pan_pal/screens/auth/auth.dart';
import 'package:pan_pal/screens/dashboard/alphabet_search.dart';
import 'package:pan_pal/screens/dashboard/recently_viewed.dart';
import 'package:pan_pal/screens/home_unauthenticated.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key, this.context}) : super(key: key);

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
          Spacer(),
          Expanded(
            flex: 4,
            child: RecentlyViewed(context: context),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                AlphabetSearch(context: context),
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
                  borderColor: Color(0xFFFFCA00),
                  color: Color(0xFFFFCA00),
                  fillColor: Color(0xFFFFCA00),
                  selectedColor: Colors.grey[850],
                  selectedBorderColor: Color(0xFFFFCA00),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                RaisedButton(
                  onPressed: () {
                    context.signOut();
                    Navigator.of(context)
                        .pushReplacement(HomeUnauthenticated.route);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Color(0xff0F4FA8),
                  child: const Text('Sign Out'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
