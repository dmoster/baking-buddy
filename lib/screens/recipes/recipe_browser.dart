import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:pan_pal/routes.dart';
import 'package:pan_pal/screens/recipes/recipe.dart';
import 'package:pan_pal/screens/recipes/recipe_viewer.dart';

class RecipeBrowser extends StatefulWidget {
  static const routeName = '/recipe_browser';

  @override
  _RecipeBrowserState createState() => _RecipeBrowserState();
}

class _RecipeBrowserState extends State<RecipeBrowser> {
  @override
  Widget build(BuildContext context) {
    final litUser = context.getSignedInUser();

    return Scaffold(
      backgroundColor: Color(0xff072F66),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff072F66),
        toolbarHeight: 32,
        title: Text(
          'Recipe Browser',
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
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView(
                          children: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            return Container(
                              padding: EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 1),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(8.0),
                                horizontalTitleGap: 8.0,
                                tileColor: Colors.white10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                leading: Container(
                                  width: 64,
                                  child: document.data()['imageUrl'] != ''
                                      ? Image.network(
                                          document.data()['imageUrl'],
                                          fit: BoxFit.cover,
                                        )
                                      : Center(
                                          child:
                                              Icon(Icons.camera_alt_outlined),
                                        ),
                                ),
                                title: Text(
                                  document.data()['name'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                  ),
                                ),
                                subtitle: Text(
                                  document.data()['category'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                onTap: () {
                                  Recipe recipe =
                                      Recipe.fromJson(document.data());
                                  Navigator.pushNamed(
                                    context,
                                    RecipeViewer.routeName,
                                    arguments: RecipePageArguments(
                                        recipe, 'Recipe Browser'),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        );
                      }
                      return Center(
                        child: Text(
                          'Loading...',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                );
              },
              empty: () {},
              initializing: () {},
            ),
            Row(
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Color(0xff0F4FA8),
                  child: const Text('Dashboard'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
