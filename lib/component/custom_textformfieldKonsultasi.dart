import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String labelText;
  final String? initialValue;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool obscureText;
  final String? hintText;
  final double? height; // Add a height property
  final EdgeInsetsGeometry? contentPadding; // Add contentPadding property

  const CustomTextFieldWidget({
    Key? key,
    required this.labelText,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.obscureText = false,
    this.hintText,
    this.height, // Initialize the height property
    this.contentPadding, // Initialize contentPadding property
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: SizedBox(
        height: height, // Set the height here
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: null, // Allow multiple lines
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText, // Adding the hint text here
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            contentPadding: contentPadding ?? const EdgeInsets.all(20.0), // Use contentPadding property here
            alignLabelWithHint: true, // Align label with top left corner
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Color.fromRGBO(30, 84, 135, 1),
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
      ),
    );
  }
}
