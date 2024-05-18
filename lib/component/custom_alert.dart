import 'package:flutter/material.dart';
class CostumAlert{
  static void show(BuildContext context, String message, String title, IconData icon, Color color){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: contentBox(context, message, title, icon, color),
        );
      },
    );
  }
}
Widget contentBox(BuildContext context, String message, String title, IconData icon, Color color) {
  return Stack(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.only(
          left: 20,
          top: 45,
          right: 20,
          bottom: 20,
        ),
        margin: const EdgeInsets.only(top: 45),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 10),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              message,
              style: const TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'OKE',
                  style: TextStyle(color: Color.fromRGBO(203, 164, 102, 1)),
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: 0,
        left: 20,
        right: 20,
        child: CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    ],
  );
}