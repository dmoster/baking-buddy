import 'package:flutter/material.dart';
import 'package:pan_pal/routes.dart';
import 'package:pan_pal/screens/dashboard/recent_item_button.dart';
import 'package:pan_pal/screens/ingredients/ingredient.dart';
import 'package:pan_pal/screens/ingredients/ingredient_row_display.dart';
import 'package:pan_pal/screens/ingredients/ingredientslist.dart';
import 'package:pan_pal/screens/recipes/recipe_viewer.dart';

class RecentlyViewed extends StatefulWidget {
  const RecentlyViewed(
      {Key key,
      @required this.context,
      @required this.ingredients,
      @required this.recentlyViewed})
      : super(key: key);

  final List<dynamic> recentlyViewed;
  final IngredientsList ingredients;
  final BuildContext context;

  @override
  _RecentlyViewedState createState() => _RecentlyViewedState();
}

class _RecentlyViewedState extends State<RecentlyViewed> {
  bool hasHistory = false;

  @override
  void initState() {
    super.initState();
    if (widget.recentlyViewed.length > 0) {
      hasHistory = true;
    }
    ;
  }

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
              ..._getRecents(),
              // hasHistory
              //     ? _getRecents()
              //     : Container(
              //         padding: EdgeInsets.only(top: 64),
              //         child: Center(
              //           child: Text(
              //             'No recent items available.',
              //             style: TextStyle(color: Colors.white),
              //           ),
              //         ),
              //       ),
              // RecentItemButton(
              //     label: Text(
              //   'Chocolate Chip Cookies',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 24,
              //   ),
              // )),
              // RecentItemButton(
              //   label: Container(
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         IngredientRowDisplay(
              //           labelSize: 24,
              //           amount: 2.25,
              //           measurementType: 'cups',
              //           refIngredient: widget.ingredients
              //               .getIngredient("All-Purpose Flour"),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // RecentItemButton(
              //     label: Text(
              //   'Allweek Bread',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 24,
              //   ),
              // )),
              // RecentItemButton(
              //   label: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       IngredientRowDisplay(
              //         labelSize: 24,
              //         amount: 55,
              //         measurementType: 'teaspoons',
              //         refIngredient:
              //             widget.ingredients.getIngredient("Marzipan"),
              //       ),
              //     ],
              //   ),
              // ),
              // RecentItemButton(
              //   label: Text(
              //     'White Chocolate Crème Brûlée',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 24,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _getRecents() {
    List<Widget> recents = [];

    if (widget.recentlyViewed.length > 0) {
      while (widget.recentlyViewed.length > 5) {
        widget.recentlyViewed.removeLast();
      }

      for (var item in widget.recentlyViewed) {
        if (item is Ingredient) {
          recents.insert(
            0,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: IngredientRowDisplay(
                  labelSize: 24,
                  amount: item.amount,
                  measurementType: item.measurementType,
                  refIngredient: item.refIngredient),
            ),
          );
        } else {
          recents.insert(
            0,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RecentItemButton(
                label: Text(
                  item.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                onPressed: () => Navigator.pushNamed(
                  context,
                  RecipeViewer.routeName,
                  arguments: RecipeViewerArguments(
                    item,
                    'Dashboard',
                    widget.recentlyViewed,
                    false,
                  ),
                ),
              ),
            ),
          );
        }
      }
    } else {
      recents.add(
        Container(
          padding: EdgeInsets.only(top: 64),
          child: Center(
            child: Text(
              'No recent items available.',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }

    return recents;
  }
}
