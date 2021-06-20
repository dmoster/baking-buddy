import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:pan_pal/screens/dashboard/recently_viewed.dart';
import 'package:pan_pal/screens/recipes/recipe.dart';
import 'package:pan_pal/screens/recipes/recipe_components/edit_button.dart';
import 'package:pan_pal/screens/recipes/recipe_components/recipe_header.dart';
import 'package:pan_pal/utilities/local_data.dart';
import 'package:pan_pal/widgets/palette.dart';

class RecipeViewer extends StatefulWidget {
  const RecipeViewer({
    Key key,
    @required this.recipe,
    @required this.returnScreen,
    @required this.recentlyViewed,
    @required this.addToRecents,
    @required this.userId,
  }) : super(key: key);

  final Recipe recipe;
  final String returnScreen;
  final List<dynamic> recentlyViewed;
  final bool addToRecents;
  final String userId;

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
      cleanRecents(widget.recentlyViewed);

      List<dynamic> recentsJson = [];
      recentsJson = widget.recentlyViewed.map((var item) {
        return item.toJson();
      }).toList();

      writeRecents(jsonEncode(recentsJson));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette().offLight,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Palette().offLight,
        toolbarHeight: 48,
        title: Text(
          'Recipe Viewer',
          style: TextStyle(
            color: Palette().dark,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          tooltip: 'Edit',
          color: Palette().darkIcon,
          onPressed: () => Navigator.pop(context, widget.recentlyViewed),
        ),
        actions: [
          EditButton(
            userId: widget.userId,
            recipeUserId: widget.recipe.author,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0.0),
              children: [
                // Header
                RecipeHeader(
                  imageUrl: widget.recipe.imageUrl,
                  recipeName: widget.recipe.name,
                  recipeCategory: widget.recipe.category,
                  recipeRating: widget.recipe.rating,
                  recipeNumRatings: widget.recipe.numRatings,
                ),
                // Ingredients
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                ..._displayIngredients(),
                // Instructions
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                ..._displayInstructions(),
                ..._displayNotesSection(),
                ..._displayStorySection(),
                SizedBox(height: 32.0),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
          ),
        ],
      ),
    );
  }

  List<dynamic> _displayIngredients() {
    List<dynamic> ingredientRows = [];
    for (var ingredient in widget.recipe.ingredients) {
      ingredientRows.add(Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: ingredient.displayRow(Palette().dark),
      ));
    }
    return ingredientRows;
  }

  List<dynamic> _displayInstructions() {
    List<dynamic> instructionRows = [];
    for (int i = 0; i < widget.recipe.instructions.length; ++i) {
      instructionRows.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
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
                      color: Palette().dark,
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
                    color: Palette().dark,
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
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
      );
      notesRows.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 8, 32, 0),
          child: Text(
            widget.recipe.notes,
            style: TextStyle(
              color: Palette().dark,
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
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
      );
      storyRows.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 8, 32, 0),
          child: Text(
            widget.recipe.story,
            style: TextStyle(
              color: Palette().dark,
              fontSize: 16,
            ),
          ),
        ),
      );
    }
    return storyRows;
  }
}
