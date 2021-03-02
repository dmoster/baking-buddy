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
      child: Wrap(
        spacing: 16,
        runSpacing: 4,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            refIngredient.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: labelSize,
            ),
          ),
          Chip(
            padding: EdgeInsets.all(4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Color(0xFFFFCA00),
            label: Wrap(
              spacing: 12,
              runSpacing: 4,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  volume,
                  style: TextStyle(
                    color: Color(0xff323232),
                    fontSize: 16,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ounces,
                      style: TextStyle(
                        color: Color(0xff323232),
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      grams,
                      style: TextStyle(
                        color: Color(0xff323232),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
