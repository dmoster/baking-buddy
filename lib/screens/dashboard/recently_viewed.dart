import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pan_pal/routes.dart';
import 'package:pan_pal/screens/dashboard/recent_item_button.dart';
import 'package:pan_pal/screens/ingredients/ingredient.dart';
import 'package:pan_pal/screens/ingredients/ingredient_row_display.dart';
import 'package:pan_pal/screens/ingredients/ingredientslist.dart';
import 'package:pan_pal/screens/recipes/recipe.dart';
import 'package:pan_pal/screens/recipes/recipe_viewer.dart';
import 'package:pan_pal/utilities/local_data.dart';

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

    readRecents().then((String data) {
      setState(() {
        recentsFromJson(data);
      });
    });
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
              ..._getRecents().reversed,
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _getRecents() {
    List<Widget> recents = [];

    if (widget.recentlyViewed.length > 0) {
      for (var item in widget.recentlyViewed) {
        if (item is Ingredient) {
          recents.add(
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
          recents.add(
            RecentItemButton(
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

  void recentsFromJson(String data) {
    //writeRecents('');
    List<dynamic> recentsStrList = jsonDecode(data);

    widget.recentlyViewed.clear();

    for (var item in recentsStrList) {
      if (item['author'] != null) {
        widget.recentlyViewed.add(Recipe.fromJson(item));
      } else {
        widget.recentlyViewed.add(Ingredient.fromJson(item));
      }
    }

    cleanRecents(widget.recentlyViewed);
  }
}

void cleanRecents(List<dynamic> recentlyViewed) {
  while (recentlyViewed.length > 10) {
    recentlyViewed.removeAt(0);
  }
}
