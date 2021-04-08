import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:pan_pal/routes.dart';
import 'package:pan_pal/screens/recipes/recipe.dart';
import 'package:pan_pal/screens/recipes/recipe_browser_list_tile.dart';
import 'package:pan_pal/screens/recipes/recipe_viewer.dart';
import 'package:pan_pal/utilities/local_data.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pan_pal/widgets/palette.dart';

class RecipeBrowser extends StatefulWidget {
  const RecipeBrowser({
    Key key,
    @required this.recentlyViewed,
    this.searchLetter,
  }) : super(key: key);

  final List<dynamic> recentlyViewed;
  final String searchLetter;

  static const routeName = '/recipe_browser';

  @override
  _RecipeBrowserState createState() => _RecipeBrowserState();
}

class _RecipeBrowserState extends State<RecipeBrowser> {
  List<Recipe> localRecipes = [];

  @override
  void initState() {
    super.initState();
    readRecipes().then((String data) {
      setState(() {
        localRecipes = recipesFromJson(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final litUser = context.getSignedInUser();

    String searchLetter = widget.searchLetter;
    bool hasSearchLetter = searchLetter != '' ? true : false;

    return Scaffold(
      backgroundColor: Palette().offLight,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Palette().offLight,
        toolbarHeight: hasSearchLetter ? 96 : 48,
        title: Text(
          'Recipe Browser',
          style: TextStyle(
            color: Palette().dark,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          color: Palette().darkIcon,
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: Size(200, 32),
          child: Visibility(
            visible: hasSearchLetter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Icon(
                        Icons.filter_alt_outlined,
                        color: Palette().darkIcon,
                      ),
                      Text(
                        'Filters',
                        style: TextStyle(
                          color: Palette().dark,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Chip(
                        label: Text(
                          'Starts with "' + searchLetter + '"',
                          style: TextStyle(
                            color: Palette().dark,
                          ),
                        ),
                        backgroundColor: Palette().secondary,
                        // deleteIconColor: Color(0xFFFF9F00),
                        // onDeleted: () {
                        //   setState(() {
                        //     searchLetter = '';
                        //     hasSearchLetter = false;
                        //   });
                        // },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            litUser.when(
              (user) {
                final Query recipes = FirebaseFirestore.instance
                    .collection('recipes')
                    .where('author', isEqualTo: user.uid);
                return Expanded(
                  child: FutureBuilder<QuerySnapshot>(
                    future: recipes.get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Something went wrong. Please try again later.',
                            style: TextStyle(color: Palette().dark),
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        updateLocalRecipeCache(snapshot.data.docs);
                        return ListView(
                          children: snapshot.data.docs
                              .where((DocumentSnapshot document) => document
                                  .data()['name']
                                  .startsWith(searchLetter))
                              .map((DocumentSnapshot document) {
                            return RecipeBrowserListTile(
                              imageUrl: document.data()['imageUrl'],
                              name: document.data()['name'],
                              category: document.data()['category'],
                              rating: document.data()['rating'],
                              numRatings: document.data()['numRatings'],
                              onTap: () {
                                Recipe recipe =
                                    Recipe.fromJson(document.data());
                                Navigator.pushNamed(
                                  context,
                                  RecipeViewer.routeName,
                                  arguments: RecipeViewerArguments(
                                    recipe,
                                    'Recipe Browser',
                                    widget.recentlyViewed,
                                    true,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        );
                      }
                      // Show locally-cached recipes if no network connection
                      // or while loading remote data
                      return ListView(
                        children: localRecipes
                            .where((Recipe recipe) =>
                                recipe.name.startsWith(searchLetter))
                            .map((Recipe recipe) {
                          return RecipeBrowserListTile(
                            imageUrl: recipe.imageUrl,
                            name: recipe.name,
                            category: recipe.category,
                            rating: recipe.rating,
                            numRatings: recipe.numRatings,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RecipeViewer.routeName,
                                arguments: RecipeViewerArguments(
                                  recipe,
                                  'Recipe Browser',
                                  widget.recentlyViewed,
                                  true,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                );
              },
              empty: () {
                return Center(
                  child: Text(
                    "We're having trouble connecting to the server. Please log out and back in again.",
                    style: TextStyle(color: Palette().dark),
                  ),
                );
              },
              initializing: () {},
            ),
            Row(
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}

List<Recipe> recipesFromJson(String data) {
  Map<String, dynamic> recipesStrList = jsonDecode(data);
  List<Recipe> recipes = [];

  for (var item in recipesStrList.values) {
    recipes.add(Recipe.fromJson(item));
  }

  return recipes;
}
