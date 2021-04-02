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
    @required this.textColor,
    this.isDashboardItem = false,
  }) : super(key: key);

  final double labelSize;
  final double amount;
  final dynamic measurementType;
  final Ingredient refIngredient;
  final dynamic textColor;
  final bool isDashboardItem;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isDashboardItem
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: isDashboardItem ? 0 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  volume.trim(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: textColor,
                    fontSize: labelSize,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      ounces,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      grams,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 16.0,
          ),
          Flexible(
            flex: isDashboardItem ? 0 : 2,
            fit: FlexFit.loose,
            child: Text(
              refIngredient.name,
              style: TextStyle(
                color: textColor,
                fontSize: labelSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
