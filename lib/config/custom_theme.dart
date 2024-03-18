import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData theme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Colors.white,
      secondary: const Color.fromARGB(255, 133, 128, 128),
      background: const Color.fromARGB(255, 45, 15, 50),
      onBackground: const Color.fromARGB(255, 87, 25, 98),
      error: Colors.red,
      scrim: Colors.grey.shade600,
      onPrimary: const Color.fromRGBO(55, 164, 94, 1),
      onPrimaryContainer: Colors.green,
    ),
  );
}
