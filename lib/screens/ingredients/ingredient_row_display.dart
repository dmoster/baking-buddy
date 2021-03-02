import 'package:flutter/material.dart';
import 'package:pan_pal/screens/calc/formatNumbers.dart';
import 'package:pan_pal/screens/ingredients/ingredient.dart';
import 'package:pan_pal/screens/calc/converter.dart';

class IngredientRowDisplay extends StatelessWidget {
  const IngredientRowDisplay({
    Key key,
    @required this.amount,
    @required this.measurementType,
    @required this.refIngredient,
  }) : super(key: key);

  final double amount;
  final dynamic measurementType;
  final Ingredient refIngredient;

  @override
  Widget build(BuildContext context) {
    dynamic volume =
        getConvertedAmount(amount, measurementType, 'volume', refIngredient);
    dynamic ounces = formatNumber(getConvertedAmount(
            amount, measurementType, 'ounces', refIngredient)) +
        ' oz';
    dynamic grams = formatNumber(getConvertedAmount(
            amount, measurementType, 'grams', refIngredient)) +
        ' g';

    return Container(
      child: Row(
        children: [
          Text(refIngredient.name),
          Column(
            children: [
              Text(ounces),
              Text(grams),
              Text(volume),
            ],
          ),
        ],
      ),
    );
  }
}
