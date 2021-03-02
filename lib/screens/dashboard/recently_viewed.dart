import 'package:flutter/material.dart';
import 'package:pan_pal/screens/dashboard/alphabet_search_button.dart';
import 'package:pan_pal/screens/dashboard/recent_item_button.dart';
import 'package:pan_pal/screens/ingredients/ingredient_row_display.dart';
import 'package:pan_pal/screens/ingredients/ingredientslist.dart';

class RecentlyViewed extends StatefulWidget {
  const RecentlyViewed(
      {Key key, @required this.context, @required this.ingredients})
      : super(key: key);

  final IngredientsList ingredients;
  final BuildContext context;

  @override
  _RecentlyViewedState createState() => _RecentlyViewedState();
}

class _RecentlyViewedState extends State<RecentlyViewed> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        Expanded(
          child: ListView(
            children: [
              RecentItemButton(
                  label: Text(
                'Chocolate Chip Cookies',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              )),
              RecentItemButton(
                label: IngredientRowDisplay(
                  labelSize: 24,
                  amount: 2.25,
                  measurementType: 'cups',
                  refIngredient:
                      widget.ingredients.getIngredient("All-Purpose Flour"),
                ),
              ),
              RecentItemButton(
                  label: Text(
                'Allweek Bread',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              )),
              RecentItemButton(
                label: IngredientRowDisplay(
                  labelSize: 24,
                  amount: 55,
                  measurementType: 'teaspoons',
                  refIngredient: widget.ingredients.getIngredient("Marzipan"),
                ),
              ),
              RecentItemButton(
                  label: Text(
                'White Chocolate Crème Brûlée',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }
}
