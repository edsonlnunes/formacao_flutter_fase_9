import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData darkTheme() {
  const Color primaryColor = Color(0xFF168AAD);
  const Color secondaryColor = Color(0xFF34A0A4);

  return ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: Colors.black,
    primarySwatch: getMaterialColor(primaryColor),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: primaryColor),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(primaryColor),
    ),
    cardTheme: CardTheme(
      color: primaryColor.withOpacity(.5),
      elevation: 5,
      shadowColor: Colors.white.withOpacity(.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    dividerColor: Colors.white,
    extensions: [
      AppColors(
        primaryColor: getMaterialColor(primaryColor),
        secondaryColor: getMaterialColor(secondaryColor),
      )
    ],
  );
}

ThemeData lightTheme() {
  const Color primaryColor = Color(0xFF168AAD);
  const Color secondaryColor = Color(0xFF34A0A4);

  return ThemeData(
    brightness: Brightness.light,
    primarySwatch: getMaterialColor(primaryColor),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: primaryColor),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
    ),
    cardTheme: CardTheme(
      color: primaryColor.withOpacity(.5),
      shadowColor: primaryColor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.bold,
      ),
    ),
    extensions: [
      AppColors(
        primaryColor: getMaterialColor(primaryColor),
        secondaryColor: getMaterialColor(secondaryColor),
      )
    ],
  );
}

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}
