import 'package:flutter/material.dart';
import '../Style/styleapp.dart';
import 'AnimationConfig/custom_animate_border.dart';

/*

Di dalam file ini, terdapat beberapa class yang bisa kamu panggil pada file View.
Diantaranya adalah:
- RegularTextField
- AnimateTextField

Contoh pemanggilan salah satu class diatas:
Align(
  alignment: FractionalOffset.center,
  child: AnimateTextField(
    controller: usernameController,
    labelText: 'Username',
    icon: Icon(Icons.mail),
    containerColor: Colors.grey,
    containerOpacity: 0.2,
    containerRadius: 5,
    borderAnimationColor: Colors.green,
    borderAnimationRadius: 5,
  )
),

 */

// Tampilan Reguler dari TextField
class RegularTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final BorderRadius? borderRadius;
  final double borderSize;
  final EdgeInsets? margin;
  final TextAlign textAlign;
  final String? labelText;
  final TextStyle? labelStyle;
  final int maxLinesLabel;
  final String? hintText;
  final Icon? icon;
  final Color? containerColor;
  final Color? borderColor;
  final double containerOpacity;
  final double borderOpacity;

  const RegularTextField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.labelText,
    this.labelStyle,
    this.maxLinesLabel = 1,
    this.hintText,
    this.margin,
    this.borderRadius,
    this.borderSize = 1,
    this.textAlign = TextAlign.left,
    this.containerColor,
    this.borderColor,
    this.containerOpacity = 1.0,
    this.borderOpacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Color labelColor = themeData.brightness == Brightness.light ? Colors.black : Colors.white;

    List<Widget> widgets = [];

    // Fungsi untuk menambahkan labelText diatas TextFormField
    if (labelText != null && labelText!.isNotEmpty) {
      widgets.add(
        Text(
          labelText!,
          overflow: TextOverflow.ellipsis,
          maxLines: maxLinesLabel,
          style: labelStyle ?? StyleApp.mediumTextStyle.copyWith(color: labelColor),
        ),
      );
      widgets.add(const SizedBox(height: 5));
    }

    widgets.add(
      Container(
        margin: margin,
        decoration: BoxDecoration(
          color: containerColor?.withOpacity(containerOpacity),
          borderRadius: borderRadius,
          border: Border.all(
            color: borderColor?.withOpacity(borderOpacity) ?? Colors.transparent,
            width: borderSize,
          ),
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          cursorColor: labelColor,
          style: StyleApp.mediumInputTextStyle.copyWith(
            color: labelColor,
          ),
          textAlign: textAlign,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: icon,
            border: InputBorder.none,
          ),
        ),
      ),
    );

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widgets,
      ),
    );
  }
}

// Tampilan TextField dengan animasi
class AnimateTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final double borderSize;
  final EdgeInsets? margin;
  final EdgeInsets? marginTextField;
  final TextAlign textAlign;
  final String? labelText;
  final Icon? icon;
  final Color? containerColor;
  final Color? borderColor;
  final Color borderAnimationColor;
  final double containerOpacity;
  final double borderOpacity;
  final BorderRadius? borderRadius;
  final double containerRadius;
  final double borderAnimationRadius;
  final int animateDuration;

  const AnimateTextField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.labelText,
    this.margin,
    this.marginTextField,
    this.containerRadius = 0,
    this.borderRadius,
    this.borderAnimationRadius = 0,
    this.animateDuration = 500,
    this.borderSize = 1,
    this.textAlign = TextAlign.left,
    this.containerColor,
    this.borderColor,
    this.borderAnimationColor = Colors.transparent,
    this.containerOpacity = 1.0,
    this.borderOpacity = 1.0,
  });

  @override
  _AnimateTextFieldState createState() => _AnimateTextFieldState();
}

class _AnimateTextFieldState extends State<AnimateTextField> with SingleTickerProviderStateMixin {
  late AnimationController? controller;
  late Animation<double> alpha;
  final focusNode = FocusNode();

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animateDuration),
    );
    final Animation<double> curve =
    CurvedAnimation(parent: controller!, curve: Curves.easeInOut);
    alpha = Tween(begin: 0.0, end: 1.0).animate(curve);

    controller?.addListener(() {
      setState(() {});
    });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        controller?.forward();
      } else {
        controller?.reverse();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Color labelColor = themeData.brightness == Brightness.light ? Colors.black : Colors.white;

    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.containerColor?.withOpacity(widget.containerOpacity),
        borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.containerRadius),
        border: Border.all(
          color: widget.borderColor?.withOpacity(widget.borderOpacity) ?? Colors.transparent,
          width: widget.borderSize,
        ),
      ),
      child: Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: widget.borderAnimationColor,
          ),
        ),
        child: CustomPaint(
          painter: CustomAnimateBorder(alpha.value, widget.borderAnimationColor, widget.borderAnimationRadius),
          child: Padding(
            padding: widget.marginTextField ?? EdgeInsets.zero,
            child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              cursorColor: labelColor,
              style: StyleApp.mediumInputTextStyle.copyWith(
                color: labelColor,
              ),
              textAlign: widget.textAlign,
              focusNode: focusNode,
              decoration: InputDecoration(
                label: Text(
                  widget.labelText ?? "",
                  style: TextStyle(color: labelColor),
                ),
                prefixIcon: widget.icon,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

