import 'package:flutter/material.dart';

class NavigationUtils {
  /// Pushes a new screen onto the navigation stack
  static Future<T?> push<T extends Object?>(
    BuildContext context,
    Widget screen,
  ) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  /// Replaces the current screen with a new one
  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context,
    Widget screen,
  ) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  /// Pops the current screen
  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }
}