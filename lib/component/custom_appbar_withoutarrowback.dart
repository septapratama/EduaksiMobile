import 'package:flutter/material.dart';

class appbarwithoutarrow extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color titleColor;
  final bool centerTitle;

  const appbarwithoutarrow({
    Key? key,
    required this.title,
    this.backgroundColor = const Color.fromRGBO(30, 84, 135, 1),
    this.titleColor = Colors.white,
    this.centerTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontFamily: 'Poppins_Bold',
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
