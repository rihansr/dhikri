import 'package:dhikri/values/dimens.dart';
import 'package:flutter/material.dart';

final style = Style.value;

class Style {
  static Style get value => Style._();
  Style._();

  TextStyle get headlineTitleStyle => TextStyle(
        color: Colors.white,
        fontSize: dimen.fontSize_20,
        fontFamily: "Work Sans",
        fontWeight: FontWeight.w700,
      );

  TextStyle get headlineSubTitleStyle => TextStyle(
        color: Colors.white,
        fontSize: dimen.fontSize_16,
        fontFamily: "Work Sans",
        fontWeight: FontWeight.w500,
      );

  TextStyle get titleStyle => TextStyle(
        color: Colors.white,
        fontSize: dimen.fontSize_16,
        fontFamily: "Work Sans",
        fontWeight: FontWeight.w500,
        height: 1.5,
      );

  TextStyle get labelStyle => TextStyle(
        color: Colors.white,
        fontSize: dimen.fontSize_14,
        fontFamily: "Work Sans",
        fontWeight: FontWeight.w400,
      );

  TextStyle get textStyle => TextStyle(
        color: Colors.white,
        fontSize: dimen.fontSize_15,
        fontFamily: "Work Sans",
        fontWeight: FontWeight.w400,
        height: 1.5,
      );
}
