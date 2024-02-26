import 'package:flutter/material.dart';
import '../../Layout/Style/styleapp.dart';

class RegularComboBoxField<T> extends StatelessWidget {
  final BorderRadius? borderRadius;
  final double borderSize;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final TextStyle? labelStyle;
  final int maxLinesLabel;
  final String? hintText;
  final Icon? icon;
  final Color? containerColor;
  final Color? borderColor;
  final double containerOpacity;
  final double borderOpacity;
  final List<T>? items;
  final T? value;
  final ValueChanged<T?>? onChanged;

  const RegularComboBoxField({
    Key? key,
    this.icon,
    this.labelStyle,
    this.maxLinesLabel = 5,
    this.hintText,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
    this.borderSize = 1,
    this.containerColor,
    this.borderColor,
    this.containerOpacity = 1.0,
    this.borderOpacity = 1.0,
    this.items,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: containerColor?.withOpacity(containerOpacity),
        borderRadius: borderRadius,
        border: Border.all(
          color: borderColor?.withOpacity(borderOpacity) ?? Colors.transparent,
          width: borderSize,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonFormField<T>(
            value: value,
            items: items?.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Tooltip(
                  message: item.toString(),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: borderRadius! / 2,
                      border: Border.all(
                        color: containerColor?.withOpacity(borderOpacity) ?? Colors.transparent,
                        width: borderSize,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        item.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: maxLinesLabel,
                        style: labelStyle ?? StyleApp.mediumTextStyle.copyWith(),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: icon,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
