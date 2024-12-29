// Flutter imports:
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData theme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Colors.white,
      secondary: const Color.fromARGB(255, 114, 109, 109),
      surface: const Color.fromARGB(255, 23, 22, 24),
      onSurface: const Color.fromARGB(255, 50, 46, 51),
      error: Colors.red,
      scrim: Colors.grey.shade600,
      onPrimary: const Color.fromRGBO(55, 164, 94, 1),
      onPrimaryContainer: Colors.green,
    ),
  );
}
