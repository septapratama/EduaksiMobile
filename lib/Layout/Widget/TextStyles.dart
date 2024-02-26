import 'package:flutter/material.dart';
import '../Style/styleapp.dart';

// Tampilan Judul dengan Gradasi Warna
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final List<Color> gradientColors;

  GradientText({
    required this.text,
    this.textStyle,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: gradientColors,
        ).createShader(bounds);
      },
      child: RichText(
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        text: TextSpan(
          text: text,
          style: textStyle ?? StyleApp.extraLargeTextStyle.copyWith(
              fontWeight: FontWeight.w900
          ),
        ),
      ),
    );
  }
}

// Tampilan Judul dengan Gradasi Warna
class WarningText extends StatelessWidget {
  final bool visible;
  final String text;
  final Color textColor;
  final TextStyle? textStyle;
  final Icon icon;
  final Color iconColor;
  final double iconSize;

  WarningText({
    required this.visible,
    required this.text,
    this.textColor = Colors.red,
    this.textStyle,
    this.icon = const Icon(Icons.error),
    this.iconColor = Colors.red,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child:Icon(
              icon.icon,
              color: iconColor, // Menggunakan iconColor
              size: iconSize,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: textStyle ?? StyleApp.smallTextStyle.copyWith(color: textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Tampilan Teks dengan garis di sisi kiri dan kanan
class LineText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final double lineWidth;
  final double? lineHeight;
  final double lineSpacing;
  final Color? lineColor;
  final double lineOpacity;

  LineText({
    required this.text,
    this.textStyle,
    this.lineWidth = 30,
    this.lineHeight,
    this.lineSpacing = 10,
    this.lineColor,
    this.lineOpacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Color labelColor = themeData.brightness == Brightness.light ? Colors.black : Colors.white;

    Color resolvedContainerColor = lineColor ?? labelColor;

    return Container(
      constraints: BoxConstraints(
        minWidth: 10,
        minHeight: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(
              minWidth: 10,
              maxWidth: 100,
              minHeight: 1,
            ),
            width: lineWidth,
            height: lineHeight,
            alignment: Alignment.centerRight,
            color: resolvedContainerColor.withOpacity(lineOpacity),
          ),
          SizedBox(width: lineSpacing),
          Container(
            constraints: BoxConstraints(
              maxWidth: 300,
            ),
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: textStyle ?? StyleApp.mediumTextStyle.copyWith(color: labelColor),
            ),
          ),
          SizedBox(width: lineSpacing),
          Container(
            constraints: BoxConstraints(
              minWidth: 10,
              maxWidth: 100,
              minHeight: 1,
            ),
            width: lineWidth,
            height: lineHeight,
            alignment: Alignment.centerLeft,
            color: resolvedContainerColor.withOpacity(lineOpacity),
          ),
        ],
      ),
    );
  }
}