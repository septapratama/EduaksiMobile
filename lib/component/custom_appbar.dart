import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? leadingOnPressed; // Function onPressed for back button
  final VoidCallback? buttonOnPressed; // Function onPressed for custom button
  final IconData? buttonIcon; // Icon for custom button
  final List<Widget>? actions;
  final Color backgroundColor;
  final Color titleColor;
  final String fontFamily;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leadingOnPressed, // onPressed function argument
    this.buttonOnPressed, // onPressed function argument for custom button
    this.buttonIcon, // Icon for custom button
    this.actions,
    this.backgroundColor = const Color.fromRGBO(30, 84, 135, 1), // Default background color
    this.titleColor = Colors.white, // Default title color
    this.fontFamily = 'Poppins_Bold', // Default font family
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontFamily: fontFamily,
        ),
      ),
      backgroundColor: backgroundColor,
      iconTheme: const IconThemeData(color: Colors.white), // Set the color of leading button icon
      leading: leadingOnPressed != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: leadingOnPressed,
            )
          : null,
      actions: <Widget>[
        if (buttonIcon != null && buttonOnPressed != null)
          IconButton(
            icon: Icon(buttonIcon, color: Colors.white),
            onPressed: buttonOnPressed,
          ),
        if (actions != null) ...actions!,
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
