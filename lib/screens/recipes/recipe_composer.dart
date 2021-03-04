import 'package:flutter/material.dart';
import 'package:pan_pal/screens/ingredients/ingredient.dart';
import 'package:pan_pal/screens/ingredients/ingredient_row_display.dart';
import 'package:pan_pal/screens/ingredients/ingredientslist.dart';
import 'package:pan_pal/screens/recipes/ingredient_form.dart';

class RecipeComposer extends StatefulWidget {
  const RecipeComposer({Key key, @required this.ingredients}) : super(key: key);

  final IngredientsList ingredients;

  @override
  _RecipeComposerState createState() => _RecipeComposerState();
}

class _RecipeComposerState extends State<RecipeComposer> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  static List<dynamic> ingredients = [];
  static List<dynamic> instructions = [null];

  Widget ingredient;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(32),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Row(
              children: [
                Icon(Icons.text_fields_outlined),
                SizedBox(width: 16),
                Text(
                  'Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            controller: _nameController,
            decoration: InputDecoration(hintText: 'Name your recipe'),
            validator: (v) {
              if (v.trim().isEmpty) {
                return 'Please enter a recipe name';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Row(
              children: [
                Icon(Icons.shopping_bag_outlined),
                SizedBox(width: 16),
                Text(
                  'Ingredients',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          ...ingredients,
          IngredientForm(
            context: context,
            ingredients: widget.ingredients,
            onPressed: () {},
            onAdd:
                (String ingredientName, double amount, String measurementType) {
              setState(() {
                ingredients.add(
                  IngredientRowDisplay(
                    labelSize: 16,
                    amount: amount,
                    measurementType: measurementType,
                    refIngredient:
                        widget.ingredients.getIngredient(ingredientName),
                  ),
                );
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Row(
              children: [
                Icon(Icons.list_outlined),
                SizedBox(width: 16),
                Text(
                  'Instructions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          ..._getInstructions(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Row(
              children: [
                Icon(Icons.note_outlined),
                SizedBox(width: 16),
                Text(
                  'Notes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            maxLines: 3,
            decoration:
                InputDecoration(hintText: 'Add tips, tricks, and suggests'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Row(
              children: [
                Icon(Icons.book_outlined),
                SizedBox(width: 16),
                Text(
                  'Story',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            maxLines: 8,
            decoration: InputDecoration(hintText: 'Tell us about this recipe'),
          ),
          SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                color: Color(0xFFFF9F00),
                textColor: Color(0xff323232),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/home_authenticated',
                      arguments: widget.ingredients);
                },
              ),
              RaisedButton(
                color: Color(0xff0F4FA8),
                textColor: Colors.white,
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // // Ingredients
  // List<Widget> _getIngredients() {
  //   List<Widget> ingredientTextFields = [];
  //   for (int i = 0; i < ingredients.length - 1; i++) {
  //     // ingredientTextFields.add(
  //     //   openDialog();
  //     // );
  //     ingredientTextFields.add(
  //       Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 4.0),
  //         child: Row(
  //           children: [
  //             Expanded(
  //               child: IngredientTextField(i),
  //             ),
  //             SizedBox(
  //               width: 8,
  //             ),
  //             _addRemoveIngredient(i == ingredients.length - 1, i),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  //   return ingredientTextFields;
  // }

  // Widget _addRemoveIngredient(bool add, int index) {
  //   return InkWell(
  //     onTap: () {
  //       if (add) {
  //         ingredients.add(null);
  //       } else {
  //         ingredients.removeAt(index);
  //       }
  //       setState(() {});
  //     },
  //     child: Container(
  //       width: 32,
  //       height: 32,
  //       decoration: BoxDecoration(
  //         color: add ? Colors.green : Colors.red,
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       child: Icon(
  //         add ? Icons.add : Icons.remove,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }

  // Instructions
  List<Widget> _getInstructions() {
    List<Widget> instructionTextFields = [];
    for (int i = 0; i < instructions.length; i++) {
      instructionTextFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Expanded(
                child: InstructionTextField(i),
              ),
              SizedBox(
                width: 8,
              ),
              _addRemoveInstruction(i == instructions.length - 1, i),
            ],
          ),
        ),
      );
    }
    return instructionTextFields;
  }

  Widget _addRemoveInstruction(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          instructions.add(null);
        } else {
          instructions.removeAt(index);
        }
        setState(() {});
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: add ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          add ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  // List<dynamic> _getIngredients() {
  //   if (ingredients != null) {
  //     return ingredients;
  //   }
  //   return [Container()];
  // }
}

// // Ingredients
// class IngredientTextField extends StatefulWidget {
//   IngredientTextField(this.index);

//   final int index;

//   @override
//   _IngredientTextFieldState createState() => _IngredientTextFieldState();
// }

// class _IngredientTextFieldState extends State<IngredientTextField> {
//   TextEditingController _nameController;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _nameController.text =
//           _RecipeComposerState.ingredients[widget.index] ?? '';
//     });

//     return TextFormField(
//       style: TextStyle(color: Colors.white),
//       controller: _nameController,
//       onChanged: (v) => _RecipeComposerState.ingredients[widget.index] = v,
//       decoration: InputDecoration(
//         hintText: 'Add ingredient',
//       ),
//       validator: (v) {
//         if (v.trim().isEmpty) {
//           return 'Please enter an ingredient';
//         }
//         return null;
//       },
//     );
//   }
// }

// Instructions input
class InstructionTextField extends StatefulWidget {
  InstructionTextField(this.index);

  final int index;

  @override
  _InstructionTextFieldState createState() => _InstructionTextFieldState();
}

class _InstructionTextFieldState extends State<InstructionTextField> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text =
          _RecipeComposerState.instructions[widget.index] ?? '';
    });

    return TextFormField(
      style: TextStyle(color: Colors.white),
      maxLines: 3,
      controller: _nameController,
      onChanged: (v) => _RecipeComposerState.instructions[widget.index] = v,
      decoration: InputDecoration(
        hintText: 'Add step',
      ),
      validator: (v) {
        if (v.trim().isEmpty) {
          return 'Please enter some instructions';
        }
        return null;
      },
    );
  }
}
