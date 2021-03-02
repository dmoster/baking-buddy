import 'package:flutter/material.dart';
import 'package:pan_pal/screens/ingredients/ingredient.dart';
import 'package:pan_pal/screens/ingredients/ingredientslist.dart';

class IngredientRowDisplay extends StatelessWidget {
  const IngredientRowDisplay({
    Key key,
    @required this.name,
    @required this.amount,
    @required this.measurementType,
  }) : super(key: key);

  final String name;
  final dynamic amount;
  final dynamic measurementType;
  //final Ingredient ingredient = Ingredient(name);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(name),
          Column(
            children: [
              // Text(volume),
              // Text(ounces),
              // Text(grams),
            ],
          ),
        ],
      ),
    );
  }
}
