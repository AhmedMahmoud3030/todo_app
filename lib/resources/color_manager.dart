import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorManger {
  static Color primary = Color(0xFF28ED4F);
  static Color darkGrey = const Color(0xff525252);
  static Color grey = const Color(0xff737477);
  //static Color lightGrey = Color.fromARGB(255, 217, 213, 213);
  static Color lightGrey = Color(0xFFEEEEEE);

  //new palate
  static Color darkPrimary = const Color(0xffd17d11);
  static Color lightPrimary = const Color(0xccd17d11); //color with 80 opacity
  static Color grey1 = const Color(0xff707070);
  static Color grey2 = Color.fromARGB(255, 209, 207, 207);
  static Color white = const Color(0xffffffff);
  static Color black = const Color(0xFF000000);
  static Color error = const Color(0xffe61f34);
  static Color errorLight = const Color(0xFFF06774);

  static List<Color> taskColors = [
    Colors.blueAccent.shade200,
    Colors.amberAccent.shade200,
    Colors.brown.shade200,
    Colors.cyanAccent.shade200,
    Colors.deepOrangeAccent.shade200,
    Colors.deepPurpleAccent.shade200,
    Colors.greenAccent.shade200,
    Colors.indigoAccent.shade200,
    Colors.limeAccent.shade200,
    Colors.pinkAccent.shade200,
    Colors.redAccent.shade200,
    Colors.tealAccent.shade200,
    Colors.yellowAccent.shade200,
  ];
}
