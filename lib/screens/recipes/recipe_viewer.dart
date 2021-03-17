import 'package:flutter/material.dart';
import 'package:pan_pal/routes.dart';
import 'package:pan_pal/screens/recipes/recipe.dart';
import 'package:pan_pal/screens/recipes/recipe_browser.dart';

class RecipeViewer extends StatefulWidget {
  const RecipeViewer({
    Key key,
    @required this.recipe,
    @required this.returnScreen,
    @required this.recentlyViewed,
    @required this.addToRecents,
  }) : super(key: key);

  final Recipe recipe;
  final String returnScreen;
  final List<dynamic> recentlyViewed;
  final bool addToRecents;

  static const routeName = '/recipe_viewer';

  @override
  _RecipeViewerState createState() => _RecipeViewerState();
}

class _RecipeViewerState extends State<RecipeViewer> {
  @override
  void initState() {
    super.initState();
    if (widget.addToRecents) {
      widget.recentlyViewed.add(widget.recipe);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff072F66),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff072F66),
        toolbarHeight: 32,
        title: Text(
          'Recipe Viewer',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  // Name
                  Text(
                    widget.recipe.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // Category
                  Text(
                    widget.recipe.category,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // Ingredients
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
                  ..._displayIngredients(),
                  // Instructions
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
                  ..._displayInstructions(),
                  ..._displayNotesSection(),
                  ..._displayStorySection(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context, widget.recentlyViewed);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Color(0xff0F4FA8),
                  child: Text(widget.returnScreen),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RecipeBrowser.routeName,
                      arguments: RecipeBrowserArguments(
                        widget.recentlyViewed,
                        '',
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Color(0xFFFFCA00),
                  child: const Text(
                    'Recipe Browser',
                    style: TextStyle(
                      color: Color(0xff323232),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<dynamic> _displayIngredients() {
    List<dynamic> ingredientRows = [];
    for (var ingredient in widget.recipe.ingredients) {
      ingredientRows.add(Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ingredient.displayRow(),
      ));
    }
    return ingredientRows;
  }

  List<dynamic> _displayInstructions() {
    List<dynamic> instructionRows = [];
    for (int i = 0; i < widget.recipe.instructions.length; ++i) {
      instructionRows.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    (i + 1).toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Flexible(
                flex: 11,
                fit: FlexFit.loose,
                child: Text(
                  widget.recipe.instructions[i],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return instructionRows;
  }

  List<dynamic> _displayNotesSection() {
    List<dynamic> notesRows = [];
    if (widget.recipe.notes != '') {
      notesRows.add(
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
      );
      notesRows.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Text(
            widget.recipe.notes,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      );
    }
    return notesRows;
  }

  List<dynamic> _displayStorySection() {
    List<dynamic> storyRows = [];
    if (widget.recipe.story != '') {
      storyRows.add(
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
      );
      storyRows.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Text(
            widget.recipe.story,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      );
    }
    return storyRows;
  }
}
