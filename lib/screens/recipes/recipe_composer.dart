import 'package:flutter/material.dart';
import 'package:pan_pal/routes.dart';
import 'package:pan_pal/screens/ingredients/ingredient.dart';
import 'package:pan_pal/screens/ingredients/ingredient_row_display.dart';
import 'package:pan_pal/screens/ingredients/ingredientslist.dart';
import 'package:pan_pal/screens/recipes/ingredient_form.dart';
import 'package:pan_pal/screens/recipes/recipe.dart';
import 'package:pan_pal/screens/recipes/recipe_viewer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class RecipeComposer extends StatefulWidget {
  const RecipeComposer({
    Key key,
    @required this.ingredients,
    @required this.recentlyViewed,
  }) : super(key: key);

  final IngredientsList ingredients;
  final List<dynamic> recentlyViewed;

  static const routeName = '/recipe_composer';

  @override
  _RecipeComposerState createState() => _RecipeComposerState();
}

class _RecipeComposerState extends State<RecipeComposer> {
  //final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  static List<dynamic> ingredients = [];
  static List<dynamic> instructions = [null];
  static String recipeName = '';
  static String category = '';
  static String imageUrl = '';
  static List<Ingredient> ingredientsData = [];
  static List<String> instructionsData = [];
  static String notes = '';
  static String story = '';
  static Recipe recipe;

  CollectionReference recipes =
      FirebaseFirestore.instance.collection('recipes');

  List<String> categories = [
    'Cookie',
    'Cake',
    'Pie',
    'Pastry',
    'Candy',
    'Bread',
  ];
  String categoryChosenName;

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
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xff072F66),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff072F66),
          toolbarHeight: 32,
          title: Text(
            'Add a Recipe',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            color: Colors.white54,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(32, 16, 32, 48),
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
              autofocus: true,
              validator: (v) {
                if (v.trim().isEmpty) {
                  return 'Please enter a recipe name';
                }
                return null;
              },
              onChanged: (value) {
                recipeName = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Row(
                children: [
                  Icon(Icons.category_outlined),
                  SizedBox(width: 16),
                  Text(
                    'Category',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  hint: Text(
                    'Choose a category',
                    style: TextStyle(color: Colors.white),
                  ),
                  dropdownColor: Color(0xff323232),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36,
                  isExpanded: true,
                  underline: SizedBox(),
                  value: categoryChosenName,
                  onChanged: (newValue) {
                    setState(() {
                      categoryChosenName = newValue;
                      category = categoryChosenName;
                    });
                  },
                  items: categories.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
              ),
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
            // Ingredient Display
            ...ingredients,
            IngredientForm(
              context: context,
              ingredients: widget.ingredients,
              onPressed: () {},
              onAdd: (String ingredientName, double amount,
                  String measurementType) {
                setState(() {
                  Ingredient ingredient = Ingredient.fromAmount(
                      ingredientName,
                      amount,
                      measurementType,
                      widget.ingredients.getIngredient(ingredientName));
                  ingredients.add(
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: IngredientRowDisplay(
                        labelSize: 16,
                        amount: ingredient.amount,
                        measurementType: ingredient.measurementType,
                        refIngredient: ingredient.refIngredient,
                      ),
                    ),
                  );
                  ingredientsData.add(ingredient);
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
              decoration: InputDecoration(
                hintText: 'Add tips, tricks, and suggests',
              ),
              onChanged: (value) {
                notes = value;
              },
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
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Tell us about this recipe',
              ),
              onChanged: (value) {
                story = value;
              },
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    color: Color(0xFFFF9F00),
                    textColor: Color(0xff323232),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  flex: 2,
                  child: RaisedButton(
                    color: Color(0xff0F4FA8),
                    textColor: Colors.white,
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      // if (_formKey.currentState.validate()) {
                      //   _formKey.currentState.save();
                      // }
                      if (recipeName.trim() != '' &&
                          ingredientsData.length > 0 &&
                          instructions.length > 1) {
                        recipe = saveAndSendRecipe();
                      } else {
                        print('Something is missing...');
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
                flex: 4,
                child: InstructionTextField(i),
              ),
              SizedBox(width: 16.0),
              Expanded(
                flex: 1,
                child: _addRemoveInstruction(i == instructions.length - 1, i),
              ),
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
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: add ? Color(0xff0F4FA8) : Color(0xFFFF9F00),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          add ? 'Add' : 'Delete',
          style: TextStyle(
            color: add ? Colors.white : Color(0xff323232),
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Recipe saveAndSendRecipe() {
    Recipe recipe;
    for (int i = 0; i < instructions.length; i++) {
      if (instructions[i] != null) {
        instructionsData.add(instructions[i].trim());
      }
    }

    final litUser = context.getSignedInUser();
    litUser.when(
      (user) {
        recipe = Recipe(recipeName, user.uid, category, imageUrl,
            ingredientsData, instructionsData, notes, story);
        // Save the recipe in Cloud Firestore
        uploadRecipe(recipe);

        // Reset the composer for next timeR
        ingredients = [];
        instructions = [null];
        recipeName = '';
        category = '';
        imageUrl = '';
        ingredientsData = [];
        instructionsData = [];
        notes = '';
        story = '';

        // Go to the recipe viewer
        Navigator.pushReplacementNamed(
          context,
          RecipeViewer.routeName,
          arguments: RecipeViewerArguments(
              recipe, 'Dashboard', widget.recentlyViewed, true),
        );
      },
      empty: () {},
      initializing: () {},
    );

    return null;
  }

  Future<void> uploadRecipe(Recipe recipe) {
    return recipes
        .add(recipe.toJson())
        .then((value) => print('Recipe Uploaded'))
        .catchError((error) => print('Failed to upload recipe: $error'));
  }
}

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
      controller: _nameController,
      onChanged: (value) {
        _RecipeComposerState.instructions[widget.index] = value;
      },
      decoration: InputDecoration(
        hintText: 'Add step',
      ),
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Please enter some instructions';
        }
        return null;
      },
    );
  }
}
