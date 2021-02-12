import 'package:pan_pal/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(PanPal());
}

class PanPal extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong. Please try again later.'),
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
                    )),
                home: SplashScreen(),
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        });
  }
}
