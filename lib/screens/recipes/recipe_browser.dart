import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:pan_pal/routes.dart';
import 'package:pan_pal/screens/recipes/recipe.dart';
import 'package:pan_pal/screens/recipes/recipe_viewer.dart';

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
  @override
  Widget build(BuildContext context) {
    final litUser = context.getSignedInUser();

    String searchLetter = widget.searchLetter;
    bool hasSearchLetter = searchLetter != '' ? true : false;

    return Scaffold(
      backgroundColor: Color(0xff072F66),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff072F66),
        toolbarHeight: hasSearchLetter ? 64 : 32,
        title: Text(
          'Recipe Browser',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        leading: Container(),
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
                      Icon(Icons.filter_alt_outlined),
                      Text(
                        'Filters',
                        style: TextStyle(color: Colors.white, fontSize: 16),
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
                            color: Color(0xff323232),
                          ),
                        ),
                        backgroundColor: Color(0xFFFFCA00),
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
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView(
                          children: snapshot.data.docs
                              .where((DocumentSnapshot document) => document
                                  .data()['name']
                                  .startsWith(searchLetter))
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
                                    arguments: RecipeViewerArguments(
                                      recipe,
                                      'Recipe Browser',
                                      widget.recentlyViewed,
                                      true,
                                    ),
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
                    Navigator.pop(context);
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
