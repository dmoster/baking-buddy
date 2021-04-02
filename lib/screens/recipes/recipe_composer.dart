import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pan_pal/routes.dart';
import 'package:pan_pal/screens/ingredients/ingredient.dart';
import 'package:pan_pal/screens/ingredients/ingredient_row_display.dart';
import 'package:pan_pal/screens/ingredients/ingredientslist.dart';
import 'package:pan_pal/screens/recipes/ingredient_form.dart';
import 'package:pan_pal/screens/recipes/recipe.dart';
import 'package:pan_pal/screens/recipes/recipe_viewer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pan_pal/utilities/image_uploader_button.dart';
import 'package:pan_pal/utilities/local_data.dart';
import 'package:pan_pal/widgets/palette.dart';

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
  TextEditingController _nameController;
  static String userId;
  static List<dynamic> ingredients = [];
  static List<dynamic> instructions = [null];
  static String recipeName = '';
  static String category = '';
  static String imageUrl = '';
  static List<Ingredient> ingredientsData = [];
  static List<String> instructionsData = [];
  static String notes = '';
  static String story = '';
  static ImageHandler imageHandler;
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

    final litUser = context.getSignedInUser();
    litUser.when(
      (user) {
        userId = user.uid;
        imageHandler = ImageHandler(userId);
      },
      empty: () {},
      initializing: () {},
    );
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
        backgroundColor: Palette().offLight,
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0,
          backgroundColor: Palette().offLight,
          toolbarHeight: 48,
          title: Text(
            'Add a Recipe',
            style: TextStyle(
              color: Palette().dark,
              fontSize: 16,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            color: Palette().darkIcon,
            onPressed: () {
              setState(() {
                clearForm();
              });
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(32, 16, 32, 48),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            Icon(
                              Icons.text_fields_outlined,
                              color: Palette().darkIcon,
                            ),
                            SizedBox(width: 16),
                            Text(
                              'Name',
                              style: TextStyle(
                                color: Palette().dark,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: Palette().dark,
                        ),
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Name your recipe',
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
                    ],
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: imageHandler.image == null
                      ? ImageUploaderButton(
                          onPressed: () async {
                            await imageHandler.pickImage();
                            print(imageHandler.name);
                            setState(() {});
                          },
                        )
                      : Container(
                          height: 64,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: FileImage(imageHandler.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Row(
                children: [
                  Icon(
                    Icons.category_outlined,
                    color: Palette().darkIcon,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Category',
                    style: TextStyle(
                      color: Palette().dark,
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
                  color: Palette().light,
                  border: Border.all(
                    color: Palette().inputBorder,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton(
                  style: TextStyle(
                    color: Palette().dark,
                    fontSize: 16,
                  ),
                  hint: Text(
                    'Choose a category',
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
                  Icon(
                    Icons.shopping_bag_outlined,
                    color: Palette().darkIcon,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Ingredients',
                    style: TextStyle(
                      color: Palette().dark,
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
                        textColor: Palette().dark,
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
                  Icon(
                    Icons.list_outlined,
                    color: Palette().darkIcon,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Instructions',
                    style: TextStyle(
                      color: Palette().dark,
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
                  Icon(
                    Icons.note_outlined,
                    color: Palette().darkIcon,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Notes',
                    style: TextStyle(
                      color: Palette().dark,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            TextFormField(
              style: TextStyle(
                color: Palette().dark,
              ),
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Add tips, tricks, and suggests',
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
              onChanged: (value) {
                notes = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Row(
                children: [
                  Icon(
                    Icons.book_outlined,
                    color: Palette().darkIcon,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Story',
                    style: TextStyle(
                      color: Palette().dark,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            TextFormField(
              style: TextStyle(color: Palette().dark),
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Tell us about this recipe',
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
                    color: Palette().warning,
                    textColor: Palette().dark,
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        clearForm();
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  flex: 2,
                  child: RaisedButton(
                    color: Palette().primary,
                    textColor: Palette().light,
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () async {
                      if (recipeName.trim() != '' &&
                          ingredientsData.length > 0 &&
                          instructions.length > 1) {
                        recipe = await saveAndSendRecipe();

                        // Go to the recipe viewer
                        Navigator.pushReplacementNamed(
                          context,
                          RecipeViewer.routeName,
                          arguments: RecipeViewerArguments(
                              recipe, 'Dashboard', widget.recentlyViewed, true),
                        );
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
          color: add ? Palette().primary : Palette().warning,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          add ? 'Add' : 'Delete',
          style: TextStyle(
            color: add ? Palette().light : Palette().dark,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Future<Recipe> saveAndSendRecipe() async {
    Recipe recipe;
    for (int i = 0; i < instructions.length; i++) {
      if (instructions[i] != null) {
        instructionsData.add(instructions[i].trim());
      }
    }

    if (imageHandler.image != null) {
      try {
        await imageHandler.uploadImage();
        imageUrl = imageHandler.url;
        print(imageUrl);
      } catch (e) {
        print('Error uploading image: $e');
      }
    } else {
      print('No image provided.');
    }

    recipe = Recipe(recipeName, userId, category, imageUrl, ingredientsData,
        instructionsData, notes, story);

    // Save the recipe in the local cache
    updateLocalRecipeCache([recipe.toJson()]);
    // Save the recipe in Cloud Firestore
    uploadRecipe(recipe);

    // Reset the composer for next time
    clearForm();

    return recipe;
  }

  Future<void> uploadRecipe(Recipe recipe) {
    return recipes
        .add(recipe.toJson())
        .then((value) => print('Recipe Uploaded'))
        .catchError((error) => print('Failed to upload recipe: $error'));
  }

  void clearForm() {
    ingredients = [];
    instructions = [null];
    recipeName = '';
    category = '';
    imageUrl = '';
    ingredientsData = [];
    instructionsData = [];
    notes = '';
    story = '';
    imageHandler = null;
    //_nameController.text = null;
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
      style: TextStyle(color: Palette().dark),
      controller: _nameController,
      onChanged: (value) {
        _RecipeComposerState.instructions[widget.index] = value;
      },
      decoration: InputDecoration(
        hintText: 'Add step',
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
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Please enter some instructions';
        }
        return null;
      },
    );
  }
}
