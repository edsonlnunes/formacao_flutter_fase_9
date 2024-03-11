import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData darkTheme() {
  const Color primaryColor = Colors.black;
  const Color secondaryColor = Color.fromARGB(255, 36, 36, 36);

  return ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: Colors.black,
    primarySwatch: getMaterialColor(primaryColor),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: Colors.white),
      labelStyle: const TextStyle(color: Colors.white),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      iconColor: Colors.white.withOpacity(.7),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondaryColor,
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
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        secondaryColor,
      ),
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        secondaryColor,
      ),
      foregroundColor: MaterialStateProperty.all(
        Colors.white,
      ),
    )),
    primaryIconTheme: const IconThemeData(
      color: Colors.white,
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: secondaryColor,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(color: Colors.white),
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
  const Color primaryColor = Colors.black;
  const Color secondaryColor = Color.fromARGB(255, 36, 36, 36);

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
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    primaryIconTheme: const IconThemeData(
      color: primaryColor,
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
      bodyMedium: TextStyle(color: primaryColor),
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
