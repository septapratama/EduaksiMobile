import 'package:flutter/material.dart';

class CustomButton {
  static ButtonStyle overallButtonStyle() {
    return ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      foregroundColor: Colors.white,
      backgroundColor: const Color.fromRGBO(30, 84, 135, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
