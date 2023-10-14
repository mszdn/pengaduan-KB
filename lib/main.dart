import 'package:adumas/constant/HColor.dart' as c;
import 'package:adumas/screens/pages2/postingan.dart';
import 'package:adumas/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Adumas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: c.white),
              titleTextStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: c.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ))),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        // home: const Postinganlelang());
        home: const SplashScreen());
  }
}

class HRoute extends MaterialPageRoute {
  HRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => Navigation_Route_Duration;
}

const Navigation_Route_Duration = Duration(milliseconds: 600);
