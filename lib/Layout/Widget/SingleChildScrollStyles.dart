import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FadeVerticalScrollView extends StatelessWidget {
  final Widget child;

  FadeVerticalScrollView({required this.child});

  @override
  Widget build(BuildContext context) {
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: Colors.green.withOpacity(0.5),
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Colors.transparent, Colors.black, Colors.black, Colors.transparent],
            stops: const [0.0, 0.03, 0.97, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}



