import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:pan_pal/routes.dart';
import 'package:pan_pal/screens/home_authenticated.dart';
import 'package:pan_pal/screens/home_unauthenticated.dart';
import 'package:pan_pal/screens/ingredients/ingredientslist.dart';
import 'package:pan_pal/screens/recipes/recipe_browser.dart';
import 'package:pan_pal/screens/recipes/recipe_composer.dart';
import 'package:pan_pal/screens/recipes/recipe_viewer.dart';
import 'package:pan_pal/screens/splash.dart';
import 'package:pan_pal/screens/welcome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(PanPal());
}

class PanPal extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  static IngredientsList _ingredients;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Use FutureBuilder to retrieve ingredient data
    return Directionality(
      textDirection: TextDirection.ltr,
      child: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/data/ingredientsList.json'),
        builder: (context, outerSnapshot) {
          if (!outerSnapshot.hasData) {
            return Welcome();
          } else if (outerSnapshot.data.isEmpty) {
            return Center(
              child: Text('Something went wrong! Please try again later.'),
            );
          } else {
            var ingredientsList = jsonDecode(outerSnapshot.data.toString());
            _ingredients = IngredientsList.fromMapList(ingredientsList);

            // Use another FutureBuilder to complete initialization of Firebase for user
            // authentication
            return FutureBuilder(
              future: _initialization,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child:
                        Text('Something went wrong. Please try again later.'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return LitAuthInit(
                    authProviders: AuthProviders(
                      emailAndPassword: true,
                      google: true,
                      apple: false,
                      twitter: true,
                      github: false,
                      anonymous: false,
                    ),
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                        brightness: Brightness.dark,
                        primaryColor: Colors.white,
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        textTheme: GoogleFonts.robotoTextTheme(),
                        accentColor: Colors.white,
                        appBarTheme: const AppBarTheme(
                          brightness: Brightness.dark,
                          color: Colors.white,
                        ),
                      ),
                      onGenerateRoute: (settings) {
                        if (settings.name == SplashScreen.routeName) {
                          final IngredientPageArguments args =
                              settings.arguments;
                          return MaterialPageRoute(
                            builder: (context) {
                              return SplashScreen(
                                ingredients: args.ingredients,
                              );
                            },
                          );
                        } else if (settings.name ==
                            HomeUnauthenticated.routeName) {
                          final IngredientPageArguments args =
                              settings.arguments;
                          return MaterialPageRoute(
                            builder: (context) {
                              return HomeUnauthenticated(
                                ingredients: args.ingredients,
                              );
                            },
                          );
                        } else if (settings.name ==
                            HomeAuthenticated.routeName) {
                          final HomeAuthenticatedArguments args =
                              settings.arguments;
                          return MaterialPageRoute(
                            builder: (context) {
                              return HomeAuthenticated(
                                recentlyViewed: args.recentlyViewed,
                                ingredients: args.ingredients,
                              );
                            },
                          );
                        } else if (settings.name == RecipeComposer.routeName) {
                          final RecipeComposerArguments args =
                              settings.arguments;
                          return MaterialPageRoute(
                            builder: (context) {
                              return RecipeComposer(
                                ingredients: args.ingredients,
                                recentlyViewed: args.recentlyViewed,
                              );
                            },
                          );
                        } else if (settings.name == RecipeViewer.routeName) {
                          final RecipeViewerArguments args = settings.arguments;
                          return MaterialPageRoute(
                            builder: (context) {
                              return RecipeViewer(
                                recipe: args.recipe,
                                returnScreen: args.returnScreen,
                                recentlyViewed: args.recentlyViewed,
                                addToRecents: args.addToRecents,
                                userId: args.userId,
                              );
                            },
                          );
                        } else if (settings.name == RecipeBrowser.routeName) {
                          final RecipeBrowserArguments args =
                              settings.arguments;
                          return MaterialPageRoute(
                            builder: (context) {
                              return RecipeBrowser(
                                recentlyViewed: args.recentlyViewed,
                                searchLetter: args.searchLetter,
                              );
                            },
                          );
                        }
                        return null;
                      },
                      home: SplashScreen(ingredients: _ingredients),
                      // routes: {
                      //   SplashScreen.routeName: (context) => SplashScreen(),
                      // },
                      // onGenerateRoute: (RouteSettings settings) {
                      //   var routes = <String, WidgetBuilder>{
                      //     '/splash_screen': (context) =>
                      //         SplashScreen(ingredients: settings.arguments),
                      //     '/home_unauthenticated': (context) =>
                      //         HomeUnauthenticated(
                      //             ingredients: settings.arguments),
                      //     '/home_authenticated': (context) => HomeAuthenticated(
                      //         ingredients: settings.arguments),
                      //     '/recipe_composer': (context) =>
                      //         RecipeComposer(ingredients: settings.arguments),
                      //     '/recipe_viewer': (context) =>
                      //         RecipeViewer(recipe: settings.arguments),
                      //   };
                      //   WidgetBuilder builder = routes[settings.name];
                      //   return MaterialPageRoute(
                      //       builder: (ctx) => builder(ctx),
                      //       fullscreenDialog: true);
                      // },
                    ),
                  );
                }

                return Welcome();
              },
            );
          }
        },
      ),
    );
  }
}
