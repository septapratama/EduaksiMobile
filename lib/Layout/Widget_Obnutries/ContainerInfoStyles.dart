import 'package:flutter/material.dart';
import '../../Layout/Widget/TextStyles.dart';
import '../Style/styleapp.dart';

// Tampilan Reguler dari TextField
class ContainerInfo extends StatelessWidget {
  final BorderRadius? borderRadius;
  final double borderSize;
  final EdgeInsets? margin;
  final TextAlign textAlign;
  final String labelText;
  final TextStyle? labelStyle;
  final List<Color>? gradientColor;
  final String descriptionText;
  final TextStyle? descriptionTextStyle;
  final Icon? icon;
  final Color? containerColor;
  final Color? borderColor;
  final double containerOpacity;
  final double borderOpacity;

  const ContainerInfo({
    Key? key,
    required this.labelText,
    required this.descriptionText,
    this.labelStyle,
    this.gradientColor,
    this.descriptionTextStyle,
    this.icon,
    this.margin,
    this.borderRadius,
    this.borderSize = 1,
    this.textAlign = TextAlign.left,
    this.containerColor,
    this.borderColor,
    this.containerOpacity = 1.0,
    this.borderOpacity = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Color contColor = themeData.brightness == Brightness.light ? Colors.grey.shade800 : Colors.grey.shade200;
    Color textColor = themeData.brightness == Brightness.light ? Colors.white : Colors.black;

    return Expanded(
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          color: containerColor ?? contColor.withOpacity(containerOpacity),
          borderRadius: borderRadius,
          border: Border.all(
            color: borderColor?.withOpacity(borderOpacity) ?? Colors.transparent,
            width: borderSize,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: icon!,
                    ),
                  ],
                  Flexible(
                    child: GradientText(
                      text: labelText,
                      textStyle: labelStyle ?? StyleApp.semiLargeTextStyle.copyWith(fontWeight: FontWeight.w900),
                      gradientColors: gradientColor ?? const [Colors.red, Colors.blue],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              Flexible(
                child: Text(
                  descriptionText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  textAlign: textAlign,
                  style: descriptionTextStyle ?? StyleApp.mediumTextStyle.copyWith(color: textColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
