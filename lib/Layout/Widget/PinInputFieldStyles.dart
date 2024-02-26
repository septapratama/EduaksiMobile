import 'package:flutter/material.dart';
// import 'package:pin_input_text_field/pin_input_text_field.dart';
import '../Style/styleapp.dart';
import 'AnimationConfig/custom_animate_border.dart';

class AnimatePinInputField extends StatefulWidget {
  final int pinLength;
  final TextEditingController controller;
  final textInputType;
  final double borderSize;
  final EdgeInsets? margin;
  final EdgeInsets? marginTextField;
  final Color? containerColor;
  final Color? borderColor;
  final Color borderAnimationColor;
  final double containerOpacity;
  final double borderOpacity;
  final BorderRadius? borderRadius;
  final double containerRadius;
  final double borderAnimationRadius;
  final int animateDuration;
  bool isPinValid = false;

  AnimatePinInputField({
    required this.pinLength,
    required this.controller,
    this.textInputType = TextInputType.number,
    this.margin,
    this.marginTextField,
    this.containerRadius = 0,
    this.borderRadius,
    this.borderAnimationRadius = 0,
    this.animateDuration = 500,
    this.borderSize = 1,
    this.containerColor,
    this.borderColor,
    this.borderAnimationColor = Colors.transparent,
    this.containerOpacity = 1.0,
    this.borderOpacity = 1.0,
  });

  @override
  _AnimateTextFieldState createState() => _AnimateTextFieldState();
}

class _AnimateTextFieldState extends State<AnimatePinInputField> with SingleTickerProviderStateMixin {
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
            // child: PinInputTextField(
            //   pinLength: widget.pinLength,
            //   controller: widget.controller,
            //   keyboardType: widget.textInputType,
            //   decoration: UnderlineDecoration(
            //     textStyle: StyleApp.boldLargeTextStyle.copyWith(color: Colors.black),
            //     colorBuilder: const FixedColorBuilder(Colors.transparent),
            //   ),
            //   focusNode: focusNode,
            // ),
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