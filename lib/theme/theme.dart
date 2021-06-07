import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme() {
  final green = Color(0xFF5fee48);

  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    accentColor: green,
    canvasColor: Colors.white,
    textTheme: _textTheme(),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(foregroundColor: Colors.white),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(fontWeight: FontWeight.bold)),
        foregroundColor: MaterialStateProperty.all<Color>(green),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: green),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: green,
        ),
      ),
      border: OutlineInputBorder(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(green),
      ),
    ),
    dividerTheme: DividerThemeData(thickness: 0.5),
  );
}

TextTheme _textTheme() => TextTheme(
      headline1: GoogleFonts.roboto(
        fontSize: 96,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      ),
      headline2: GoogleFonts.roboto(
        fontSize: 60,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      ),
      headline3: GoogleFonts.roboto(
        fontSize: 48,
        fontWeight: FontWeight.w400,
      ),
      headline4: GoogleFonts.roboto(
        fontSize: 34,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      headline5: GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      headline6: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      subtitle1: GoogleFonts.roboto(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
      subtitle2: GoogleFonts.roboto(
        fontSize: 14,
        color: Colors.grey[700],
        fontWeight: FontWeight.w500,
        letterSpacing: 2,
      ),
      bodyText1: GoogleFonts.openSans(
        fontSize: 16,
        color: Colors.grey[800],
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyText2: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ),
      button: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      ),
      caption: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      overline: GoogleFonts.openSans(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      ),
    );
