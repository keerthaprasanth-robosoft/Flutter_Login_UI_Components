import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF6200EE); // Purple
  static const Color accentColor = Color(0xFF03DAC5); // Teal
  static const Color backgroundColor = Color(0xFFF5F5F5); // Light gray
  static const Color textColor = Color(0xFF333333); // Dark gray

  // Correct MaterialColor for a single color
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF6200EE,
    <int, Color>{
      50: Color(0xFFE8EAF6),
      100: Color(0xFFC5CAE9),
      200: Color(0xFF9FA8DA),
      300: Color(0xFF7986CB),
      400: Color(0xFF5C6BC0),
      500: Color(0xFF3F51B5),
      600: Color(0xFF3949AB),
      700: Color(0xFF303F9F),
      800: Color(0xFF283593),
      900: Color(0xFF1A237E),
    },
  );

  // Correct gradient declaration
  static const Gradient gradientColor = LinearGradient(
    colors: [Color(0xFFFF8C42), Color(0xFFFF3A7A)], // Orange to Pink
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient linerColor = LinearGradient(
    colors: [Color(0xFFFF8C42), Color(0xFFFF3A7A)], // Orange to Pink
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}