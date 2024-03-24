// Flutter imports:
import 'package:flutter/material.dart';

class CustomSnackbar {
  static SnackBar showSnackBar({
    required String message,
    Color backgroundColor = const Color.fromARGB(255, 238, 81, 69),
  }) {
    return SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}
