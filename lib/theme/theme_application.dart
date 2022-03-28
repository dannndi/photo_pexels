import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeApplication {
  // ==========================================================================
  // Application Theme
  // ==========================================================================
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: surfaceLight,
    primaryColor: primaryColor,
    backgroundColor: surfaceLight,
    textTheme: TextTheme(
      headline1: h1,
      headline2: h2,
      headline3: h3,
      headline4: h4,
      headline5: h5,
      headline6: h6,
      subtitle1: b1,
      subtitle2: b2,
      bodyText1: b4,
      bodyText2: b5,
      button: h6,
      caption: b6,
      overline: b6,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      },
    ),
  );

  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: surfaceDark,
    backgroundColor: surfaceDark,
    primaryColor: primaryColor,
    textTheme: TextTheme(
      headline1: h1.copyWith(color: white),
      headline2: h2.copyWith(color: white),
      headline3: h3.copyWith(color: white),
      headline4: h4.copyWith(color: white),
      headline5: h5.copyWith(color: white),
      headline6: h6.copyWith(color: white),
      subtitle1: b1.copyWith(color: white),
      subtitle2: b2.copyWith(color: white),
      bodyText1: b4.copyWith(color: white),
      bodyText2: b5.copyWith(color: white),
      button: h6.copyWith(color: white),
      caption: b6.copyWith(color: white),
      overline: b6.copyWith(color: white),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      },
    ),
  );

  // ==========================================================================
  // Colors
  // ==========================================================================
  static Color primaryColor = const Color(0xFF05A081);
  static Color surfaceLight = const Color.fromARGB(255, 255, 255, 255);
  static Color surfaceDark = const Color.fromARGB(255, 33, 33, 33);
  static Color black = const Color.fromARGB(255, 40, 40, 40);
  static Color white = const Color.fromARGB(255, 247, 247, 247);

  // ==========================================================================
  // Text Style
  // ==========================================================================
  static TextStyle h1 = GoogleFonts.inter().copyWith(
    color: black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static TextStyle h2 = GoogleFonts.inter().copyWith(
    color: black,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static TextStyle h3 = GoogleFonts.inter().copyWith(
    color: black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static TextStyle h4 = GoogleFonts.inter().copyWith(
    color: black,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static TextStyle h5 = GoogleFonts.inter().copyWith(
    color: black,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
  static TextStyle h6 = GoogleFonts.inter().copyWith(
    color: black,
    fontSize: 11,
    fontWeight: FontWeight.bold,
  );
  static TextStyle b1 = GoogleFonts.inter().copyWith(
    color: black,
    fontSize: 20,
  );
  static TextStyle b2 = GoogleFonts.inter().copyWith(
    color: black,
    fontSize: 18,
  );
  static TextStyle b3 = GoogleFonts.inter().copyWith(
    color: black,
    fontSize: 16,
  );
  static TextStyle b4 = GoogleFonts.inter().copyWith(
    color: black,
    fontSize: 14,
  );
  static TextStyle b5 = GoogleFonts.inter().copyWith(
    color: black,
    fontSize: 12,
  );
  static TextStyle b6 = GoogleFonts.inter().copyWith(
    color: black,
    fontSize: 11,
  );
}
