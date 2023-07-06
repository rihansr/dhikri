import 'package:flutter/material.dart';

final style = Style.value;

class Style {
  static Style get value => Style._();
  Style._();

  TextStyle get headlineTitleStyle => const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: "Work Sans",
        fontWeight: FontWeight.w700,
      );

  TextStyle get headlineSubTitleStyle => const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: "Work Sans",
        fontWeight: FontWeight.w500,
      );

  TextStyle get titleStyle => const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: "Work Sans",
        fontWeight: FontWeight.w500,
        height: 1.5,
      );

  TextStyle get labelStyle => const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontFamily: "Work Sans",
        fontWeight: FontWeight.w400,
      );

  TextStyle get textStyle => const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontFamily: "Work Sans",
        fontWeight: FontWeight.w400,
        height: 1.5,
      );
}
