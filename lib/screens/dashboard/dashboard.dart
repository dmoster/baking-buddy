import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:pan_pal/screens/auth/auth.dart';
import 'package:pan_pal/screens/dashboard/alphabet_search_button.dart';
import 'package:pan_pal/screens/dashboard/recent_item_button.dart';
import 'package:pan_pal/screens/home_unauthenticated.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key, this.context}) : super(key: key);

  final BuildContext context;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Spacer(),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Recently Viewed',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                RecentItemButton(label: 'Chocolate Chip Cookies'),
                RecentItemButton(label: 'Hard Caramel'),
                RecentItemButton(label: 'Allweek Bread'),
                RecentItemButton(label: 'New York Cheesecake'),
                RecentItemButton(label: 'White Chocolate Crème Brûlée'),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Alphabet Search',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AlphabetSearchButton(context: context, btnText: 'A'),
                    AlphabetSearchButton(context: context, btnText: 'B'),
                    AlphabetSearchButton(context: context, btnText: 'C'),
                    AlphabetSearchButton(context: context, btnText: 'D'),
                    AlphabetSearchButton(context: context, btnText: 'E'),
                    AlphabetSearchButton(context: context, btnText: 'F'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AlphabetSearchButton(context: context, btnText: 'G'),
                    AlphabetSearchButton(context: context, btnText: 'H'),
                    AlphabetSearchButton(context: context, btnText: 'I'),
                    AlphabetSearchButton(context: context, btnText: 'J'),
                    AlphabetSearchButton(context: context, btnText: 'K'),
                    AlphabetSearchButton(context: context, btnText: 'L'),
                    AlphabetSearchButton(context: context, btnText: 'M'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AlphabetSearchButton(context: context, btnText: 'N'),
                    AlphabetSearchButton(context: context, btnText: 'O'),
                    AlphabetSearchButton(context: context, btnText: 'P'),
                    AlphabetSearchButton(context: context, btnText: 'Q'),
                    AlphabetSearchButton(context: context, btnText: 'R'),
                    AlphabetSearchButton(context: context, btnText: 'S'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AlphabetSearchButton(context: context, btnText: 'T'),
                    AlphabetSearchButton(context: context, btnText: 'U'),
                    AlphabetSearchButton(context: context, btnText: 'V'),
                    AlphabetSearchButton(context: context, btnText: 'W'),
                    AlphabetSearchButton(context: context, btnText: 'X'),
                    AlphabetSearchButton(context: context, btnText: 'Y'),
                    AlphabetSearchButton(context: context, btnText: 'Z'),
                  ],
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
