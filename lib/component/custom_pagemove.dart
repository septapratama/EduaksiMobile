import 'package:flutter/material.dart';

class pageMove {
  static PageRouteBuilder movepage(Widget tujuan) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => tujuan,
      transitionsBuilder: (_, animation, __, child) {
        return Stack(
          children: [
            FadeTransition(
              opacity: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(animation),
              child: child,
            ),
            IgnorePointer(
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, _) {
                  return Offstage(
                    offstage: animation.status != AnimationStatus.reverse,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
