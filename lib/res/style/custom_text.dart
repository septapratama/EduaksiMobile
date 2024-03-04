import 'package:flutter/material.dart';

class customText {
  static TextStyle Poppins_SemiBold(double FontSize,Color color) {
    return TextStyle(
      fontFamily: 'Poppins_SemiBold',
      color: color,
      fontSize: FontSize
    );
  }
  static TextStyle PoppinsBold(double FontSize,Color color,FontWeight){
    return TextStyle(
      fontFamily: 'Poppins_Bold',
      color: color,
      fontSize: FontSize,
      fontWeight: FontWeight
    );
  }
}






