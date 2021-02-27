import 'package:flutter/material.dart';

class RecipeComposer extends StatefulWidget {
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const RecipeComposer(),
      );

  const RecipeComposer({Key key}) : super(key: key);

  @override
  _RecipeComposerState createState() => _RecipeComposerState();
}

class _RecipeComposerState extends State<RecipeComposer> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  static List<dynamic> ingredients = [null];

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
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          child: ListView(
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
              ..._getIngredients(),
              // Row(
              //   children: [

              //     Expanded(
              //       child: TextFormField(
              //         decoration: InputDecoration(
              //           icon: Icon(Icons.shopping_bag_outlined),
              //           labelText: 'Ingredients',
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
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
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(hintText: 'Add a step'),
              ),
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
                decoration: InputDecoration(hintText: 'Add a note'),
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
                decoration:
                    InputDecoration(hintText: 'Tell us about this recipe'),
              ),
              RaisedButton(
                child: Text('Save'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getIngredients() {
    List<Widget> ingredientTextFields = [];
    for (int i = 0; i < ingredients.length; i++) {
      ingredientTextFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Expanded(
                child: IngredientTextField(i),
              ),
              SizedBox(
                width: 8,
              ),
              _addRemoveButton(i == ingredients.length - 1, i),
            ],
          ),
        ),
      );
    }
    return ingredientTextFields;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          ingredients.add(null);
        } else {
          ingredients.removeAt(index);
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
}

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
      _nameController.text =
          _RecipeComposerState.ingredients[widget.index] ?? '';
    });

    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: _nameController,
      autofocus: true,
      onChanged: (v) => _RecipeComposerState.ingredients[widget.index] = v,
      decoration: InputDecoration(
        hintText: 'Add an ingredient',
      ),
      validator: (v) {
        if (v.trim().isEmpty) {
          return 'Please enter an ingredient';
        }
        return null;
      },
    );
  }
}
