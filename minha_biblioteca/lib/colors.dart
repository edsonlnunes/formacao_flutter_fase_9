import 'package:flutter/material.dart';

const primaryColor = Color(0xFF168AAD);
const secondaryColor = Color(0xFF34A0A4);

MaterialColor getMaterialColor(Color color) {
  final red = color.red;
  final green = color.green;
  final blue = color.blue;

  var swatch = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    400: Color.fromRGBO(red, green, blue, .4),
    500: Color.fromRGBO(red, green, blue, .5),
    600: Color.fromRGBO(red, green, blue, .6),
    700: Color.fromRGBO(red, green, blue, .7),
    800: Color.fromRGBO(red, green, blue, .8),
    900: Color.fromRGBO(red, green, blue, .9),
    1000: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, swatch);
}
