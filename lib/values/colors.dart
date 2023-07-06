import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

final color = Col.value;

class Col {
  static Col get value => Col._();
  Col._();

  Color get homePrimaryColor => const Color(0xFF133548);
  Color get homeSecondaryColor => const Color(0xFF46707d);
  Color get homeEnabledColor => const Color(0xff5ba57c);
  Color get homeDisabledColor => const Color(0xffb3dce2);
  Gradient get homeScaffoldColor => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          homeSecondaryColor,
          homePrimaryColor,
        ],
      );
}
