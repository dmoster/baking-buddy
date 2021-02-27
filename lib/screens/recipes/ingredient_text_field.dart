import 'package:flutter/material.dart';
import 'package:pan_pal/screens/recipes/recipe_composer.dart';

class IngredientTextField extends StatefulWidget {
  IngredientTextField(this.index);

  final int index;

  @override
  _IngredientTextFieldState createState() => _IngredientTextFieldState();
}

class _IngredientTextFieldState extends State<IngredientTextField> {
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
      //_nameController.text = _RecipeComposerState.ingredients[widget.index] ?? '';
    });

    return TextFormField(
        //onChanged: (v) => _RecipeComposerState.ingredients[widget.index] = v,
        );
  }
}
