import 'package:flutter/material.dart';

final color = ColorPalette.light();

class ColorPalette {
  Gradient scaffold;
  Color primary;
  Color secondary;
  Color enable;
  Color disable;

  ColorPalette({
    required this.scaffold,
    required this.primary,
    required this.secondary,
    required this.enable,
    required this.disable,
  });

  factory ColorPalette.light() => ColorPalette(
        scaffold: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF46707d), Color(0xFF133548)],
        ),
        primary: const Color(0xFF133548),
        secondary: const Color(0xFF46707d),
        enable: const Color(0xff5ba57c),
        disable: const Color(0xffb3dce2),
      );
}
