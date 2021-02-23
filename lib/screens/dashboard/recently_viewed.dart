import 'package:flutter/material.dart';
import 'package:pan_pal/screens/dashboard/alphabet_search_button.dart';
import 'package:pan_pal/screens/dashboard/recent_item_button.dart';

class RecentlyViewed extends StatefulWidget {
  const RecentlyViewed({Key key, @required this.context}) : super(key: key);

  final BuildContext context;

  @override
  _RecentlyViewedState createState() => _RecentlyViewedState();
}

class _RecentlyViewedState extends State<RecentlyViewed> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Recently Viewed',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFFF9F00),
            ),
          ),
        ),
        RecentItemButton(label: 'Chocolate Chip Cookies'),
        RecentItemButton(label: 'Hard Caramel'),
        RecentItemButton(label: 'Allweek Bread'),
        RecentItemButton(label: 'New York Cheesecake'),
        RecentItemButton(label: 'White Chocolate Crème Brûlée'),
      ],
    );
  }
}
