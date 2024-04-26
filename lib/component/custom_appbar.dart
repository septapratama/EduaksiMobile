import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? leadingOnPressed; // Fungsi onPressed untuk tombol kembali
  final List<Widget>? actions;
  final Color backgroundColor;
  final Color titleColor;
  final String fontFamily;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.leadingOnPressed, // Argumen fungsi onPressed
    this.actions,
    this.backgroundColor =
        const Color.fromRGBO(30, 84, 135, 1), // Default background color
    this.titleColor = Colors.white, // Default title color
    this.fontFamily = 'Poppins_Bold', // Default font family
  }) : super(key: key);

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
<<<<<<< HEAD
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed:
            leadingOnPressed, // Menggunakan onPressed yang diberikan dari luar
      ),
      actions: actions,
=======
      iconTheme: IconThemeData(color: Colors.white), // Set the color of leading button icon
      leading: leadingOnPressed != null
          ? IconButton(
              icon: Icon(Icons.arrow_back),
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
>>>>>>> parent of 303f108 (update change content edukasi)
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
