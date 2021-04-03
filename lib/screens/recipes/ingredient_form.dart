import 'package:flutter/material.dart';
import 'package:pan_pal/screens/ingredients/ingredientslist.dart';
import 'package:pan_pal/widgets/palette.dart';

class IngredientForm extends StatefulWidget {
  const IngredientForm({
    Key key,
    @required this.context,
    @required this.onPressed,
    @required this.onAdd,
    @required this.ingredients,
  }) : super(key: key);

  final BuildContext context;
  final VoidCallback onPressed;
  final Function(String, double, String) onAdd;
  final IngredientsList ingredients;

  @override
  _IngredientFormState createState() => _IngredientFormState();
}

class _IngredientFormState extends State<IngredientForm> {
  List<String> measurementTypes = [
    'teaspoons',
    'tablespoons',
    'cups',
    'ounces',
    'grams'
  ];

  double amount;
  String ingredientChosenName;
  String measurementType;

  final amountText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          // Ingredient dropdown
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                  color: Palette().light,
                  border: Border.all(color: Palette().inputBorder, width: 1),
                  borderRadius: BorderRadius.circular(5)),
              child: DropdownButton(
                style: TextStyle(color: Palette().dark, fontSize: 16),
                hint: Text(
                  'Choose an ingredient',
                  style: TextStyle(color: Palette().darkIcon),
                ),
                dropdownColor: Palette().light,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Palette().darkIcon,
                ),
                iconSize: 36,
                isExpanded: true,
                underline: SizedBox(),
                value: ingredientChosenName,
                onChanged: (newValue) {
                  setState(() {
                    ingredientChosenName = newValue;
                  });
                },
                items: widget.ingredients.list.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem.name,
                    child: Text(valueItem.name),
                  );
                }).toList(),
              ),
            ),
          ),

          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  style: TextStyle(
                    color: Palette().dark,
                    fontSize: 16,
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: 'Amount',
                    hintStyle: TextStyle(
                      color: Palette().darkIcon,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Palette().inputBorder,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Palette().inputBorder,
                        width: 2.0,
                      ),
                    ),
                  ),
                  controller: amountText,
                  onChanged: (value) {
                    amount = double.parse(value);
                  },
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                      color: Palette().light,
                      border: Border.all(
                        color: Palette().inputBorder,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton(
                    style: TextStyle(
                      color: Palette().dark,
                      fontSize: 16,
                    ),
                    hint: Text(
                      'Measurement type',
                      style: TextStyle(
                        color: Palette().darkIcon,
                      ),
                    ),
                    dropdownColor: Palette().light,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Palette().darkIcon,
                    ),
                    iconSize: 36,
                    isExpanded: true,
                    underline: SizedBox(),
                    value: measurementType,
                    onChanged: (newValue) {
                      setState(() {
                        measurementType = newValue;
                      });
                    },
                    items: measurementTypes.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    color: Palette().warning,
                    textColor: Palette().dark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        amountText.clear();
                        ingredientChosenName = null;
                        measurementType = null;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: RaisedButton(
                    color: Palette().primary,
                    textColor: Palette().light,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      widget.onAdd(
                          ingredientChosenName, amount, measurementType);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
