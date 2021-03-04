import 'package:flutter/material.dart';
import 'package:pan_pal/screens/calc/formatNumbers.dart';
import 'package:pan_pal/screens/ingredients/ingredient.dart';
import 'package:pan_pal/screens/calc/converter.dart';

class IngredientRowDisplay extends StatelessWidget {
  const IngredientRowDisplay({
    Key key,
    @required this.labelSize,
    @required this.amount,
    @required this.measurementType,
    @required this.refIngredient,
  }) : super(key: key);

  final double labelSize;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                volume,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: labelSize,
                ),
              ),
              SizedBox(width: 16),
              Text(
                refIngredient.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: labelSize,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                ounces,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              SizedBox(width: 8),
              Text(
                grams,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
