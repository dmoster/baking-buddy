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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.text_fields_outlined),
                  labelText: 'Name',
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.shopping_bag_outlined),
                        labelText: 'Ingredients',
                      ),
                    ),
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.list_outlined),
                  labelText: 'Instructions',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.note_outlined),
                  labelText: 'Notes',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.book_outlined),
                  labelText: 'Story',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
