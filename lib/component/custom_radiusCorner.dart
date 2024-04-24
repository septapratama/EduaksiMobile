import 'package:flutter/material.dart';

class CustomRadiusTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final BorderRadius borderRadius;

  const CustomRadiusTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)), required InputDecoration decoration, required TextStyle style,
  });     
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Colors.grey[200], // Example background color
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0), // Adjust padding as needed
        ),
      ),
    );
  }
}
