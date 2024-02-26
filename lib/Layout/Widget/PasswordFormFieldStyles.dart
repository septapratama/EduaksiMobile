import 'package:flutter/material.dart';
import '../Style/styleapp.dart';
import 'AnimationConfig/custom_animate_border.dart';

class SuffixIconButton extends StatelessWidget {
  final bool obscureText;
  final Function() onPressed;

  SuffixIconButton({required this.obscureText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Color labelColor = themeData.brightness == Brightness.light ? Colors.black : Colors.white;

    return IconButton(
      icon: Icon(
        obscureText ? Icons.visibility_off : Icons.visibility,
        color: labelColor,
      ),
      onPressed: onPressed,
    );
  }
}

class AnimatePasswordField extends StatefulWidget {
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
  bool obscureText; //Penyebab @immutable karena tidak bernilai final. Abaikan peringatan tsb

  AnimatePasswordField({
    required this.controller,
    this.keyboardType = TextInputType.visiblePassword,
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
    required this.obscureText,
  });

  @override
  _AnimatePasswordFieldState createState() => _AnimatePasswordFieldState();
}

class _AnimatePasswordFieldState extends State<AnimatePasswordField> with SingleTickerProviderStateMixin {
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
              obscureText: widget.obscureText,
              decoration: InputDecoration(
                label: Text(
                  widget.labelText ?? "",
                  style: TextStyle(color: labelColor),
                ),
                suffixIcon: SuffixIconButton(
                  obscureText: widget.obscureText,
                  onPressed: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  },
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
