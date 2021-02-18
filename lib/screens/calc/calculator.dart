import 'dart:convert';

import 'package:pan_pal/screens/calc/converter.dart';
import 'package:flutter/material.dart';

import 'formatNumbers.dart';
import 'ingredient.dart';
import 'ingredientslist.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double displayTextSize = 100;
  double resultTextSize = 30;
  bool isVisible = false;

  IngredientsList ingredients;
  Ingredient ingredientChosen;
  String ingredientChosenName;

  // Button handler
  Widget calcButton(
      String btnText, Color btnColor, Color textColor, dynamic btnValue) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          calculate(btnText, btnValue);
        },
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 35,
            color: textColor,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: btnColor,
        padding: EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculator
    return FutureBuilder(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/data/ingredientsList.json'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.data.isEmpty) {
          // Cry because your app is super broken
          return Center(
            child: Text('Something went wrong! Please try again later.'),
          );
        } else {
          var ingredientsList = jsonDecode(snapshot.data.toString());
          ingredients = IngredientsList.fromList(ingredientsList);

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      hint: Text(
                        'Choose an ingredient',
                        style: TextStyle(color: Colors.white),
                      ),
                      dropdownColor: Colors.grey[850],
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 36,
                      isExpanded: true,
                      underline: SizedBox(),
                      value: ingredientChosenName,
                      onChanged: (newValue) {
                        setState(() {
                          ingredientChosenName = newValue;
                        });
                      },
                      items: ingredients.list.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem.name,
                          child: Text(valueItem.name),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                // Calculator display
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    child: Column(
                      children: [
                        Visibility(
                          visible: isVisible,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  ouncesText,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white, //Color(0xFFFFCA00),
                                    fontSize: resultTextSize,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isVisible,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    gramsText,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white, //Color(0xFFFF9F00),
                                      fontSize: resultTextSize,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                calcText,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: displayTextSize,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RaisedButton(
                              padding: EdgeInsets.fromLTRB(34, 20, 73, 20),
                              onPressed: () {
                                calculate('AC', 'AC');
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'Clear',
                                style: TextStyle(
                                    fontSize: 35, color: Colors.black),
                              ),
                              color: Colors.grey,
                            ),
                            calcButton('tsp', Color(0xff0F4FA8), Colors.white,
                                'teaspoons'),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            calcButton('7', Colors.grey[850], Colors.white, 7),
                            calcButton('8', Colors.grey[850], Colors.white, 8),
                            calcButton('9', Colors.grey[850], Colors.white, 9),
                            calcButton('T', Color(0xff0F4FA8), Colors.white,
                                'tablespoons'),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            calcButton('4', Colors.grey[850], Colors.white, 4),
                            calcButton('5', Colors.grey[850], Colors.white, 5),
                            calcButton('6', Colors.grey[850], Colors.white, 6),
                            calcButton(
                                'c', Color(0xff0F4FA8), Colors.white, 'cups'),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            calcButton('1', Colors.grey[850], Colors.white, 1),
                            calcButton('2', Colors.grey[850], Colors.white, 2),
                            calcButton('3', Colors.grey[850], Colors.white, 3),
                            calcButton('oz', Color(0xFFFFCA00), Colors.white,
                                'ounces'),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RaisedButton(
                              padding: EdgeInsets.fromLTRB(34, 20, 134, 20),
                              onPressed: () {
                                calculate('0', 0);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                '0',
                                style: TextStyle(
                                    fontSize: 35, color: Colors.white),
                              ),
                              color: Colors.grey[850],
                            ),
                            calcButton(
                                '.', Colors.grey[850], Colors.white, '.'),
                            calcButton(
                                'g', Color(0xFFFF9F00), Colors.white, 'grams'),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  dynamic calcText = '0';

  String volumeText = '';
  String ouncesText = '';
  String gramsText = '';

  dynamic result = '';
  dynamic finalResult = '';

  void calculate(btnText, btnValue) {
    if (result == '') {
      displayTextSize = 100;
      isVisible = false;
      volumeText = '';
      ouncesText = '';
      gramsText = '';
    }

    if (btnText == 'AC') {
      displayTextSize = 100;
      isVisible = false;
      calcText = '0';
      volumeText = '';
      ouncesText = '';
      gramsText = '';
      result = '';
      finalResult = '0';
    } else if (btnText == 'tsp' ||
        btnText == 'T' ||
        btnText == 'c' ||
        btnText == 'oz' ||
        btnText == 'g') {
      if (double.parse(calcText) > 0) {
        double valueToConvert = double.parse(calcText);
        ingredientChosen = ingredients.getIngredient(ingredientChosenName);

        displayTextSize = resultTextSize;
        isVisible = true;

        volumeText = getConvertedAmount(
            valueToConvert, btnValue, 'volume', ingredientChosen);
        ouncesText = formatNumber(getConvertedAmount(
                valueToConvert, btnValue, 'ounces', ingredientChosen)) +
            ' oz';
        gramsText = formatNumber(getConvertedAmount(
                valueToConvert, btnValue, 'grams', ingredientChosen)) +
            ' g';

        finalResult = volumeText;
        calcText = '0';
        result = '';
      }
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      calcText = finalResult;
    });
  }
}
