import 'package:flutter/material.dart';
import 'package:cakang/utils/pallete.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData myTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AllColor.primaryColor,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(
    const TextTheme(
      headline1: TextStyle(
        fontSize: 96,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      ),
      headline2: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w300,
        letterSpacing: -.5,
      ),
      headline3: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ),
      headline4: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      headline5: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ),
      headline6: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      bodyText1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      overline: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: .5,
      ),
    ).apply(
      bodyColor: AllColor.dark,
      displayColor: AllColor.dark,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: AllColor.darkGrey,
    ),
    filled: true,
    fillColor: AllColor.border,
    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: AllColor.outlineBorder,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AllColor.errorColor,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AllColor.outlineBorder,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AllColor.outlineBorder,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: AllColor.buttonColor,
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
    ),
  ),
  expansionTileTheme: ExpansionTileThemeData(
    collapsedTextColor: AllColor.dark,
    textColor: AllColor.dark,
    backgroundColor: AllColor.border,
    tilePadding: const EdgeInsets.symmetric(horizontal: 8),
  ),
  cardTheme: CardTheme(
    elevation: 0,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: AllColor.outlineBorder,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStatePropertyAll(AllColor.buttonColor),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: AllColor.border,
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStatePropertyAll(AllColor.buttonColor),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AllColor.bgErrorColor,
    contentTextStyle: TextStyle(
      color: AllColor.errorColor,
    ),
  ),
);
