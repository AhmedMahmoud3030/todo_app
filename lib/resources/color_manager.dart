import 'package:flutter/material.dart';

class ColorManger {
  static Color darkGrey = const Color(0xff525252);
  static Color grey = const Color(0xff737477);
  static Color lightGrey = const Color(0xFFEEEEEE);

  //new palate
  static Color splash =
      Color.fromARGB(204, 216, 106, 103); //color with 80 opacity
  static Color darkPrimary = const Color(0xccd17d11); //color with 80 opacity
  static Color primary = const Color(0xffd17d11);
  static Color lightPrimary = Color.fromARGB(255, 247, 175, 81);

  static Color white = const Color(0xffffffff);
  static Color black = const Color(0xFF000000);
  static Color veryLightBlack = Color.fromARGB(255, 95, 92, 92);
  static Color lightBlack = Color.fromRGBO(42, 40, 40, 1);
  static Color shadowBlack = Color(0x91000000);
  static Color error = const Color(0xffe61f34);
  static Color errorLight = const Color(0xFFF06774);

  static List<Color> taskColors = [
    Colors.blueAccent.shade100,
    Colors.amberAccent.shade100,
    Colors.brown.shade100,
    Colors.cyanAccent.shade100,
    Colors.deepOrangeAccent.shade100,
    Colors.deepPurpleAccent.shade100,
    Colors.greenAccent.shade100,
    Colors.indigoAccent.shade100,
    Colors.limeAccent.shade100,
    Colors.pinkAccent.shade100,
    Colors.redAccent.shade100,
    Colors.tealAccent.shade100,
    Colors.yellowAccent.shade100,
  ];
}
