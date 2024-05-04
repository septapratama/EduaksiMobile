import 'dart:async';

class SplashScreenController {
  late Timer _mainImageTimer;
  late Timer _newImageTimer;
  late Timer? _blinkTimer;
  bool _blink = true;

  void startBlinking(Function(bool) blinkCallback) {
    _blinkTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!timer.isActive) return;
      blinkCallback(_blink);
      _blink = !_blink;
    });
  }

  void cancelBlinking() {
    _blinkTimer?.cancel();
  }

  void startTimers(Function() mainImageTimerCallback, Function() newImageTimerCallback) {
    _mainImageTimer = Timer(const Duration(seconds: 1), () {
      mainImageTimerCallback();
    });
    _newImageTimer = Timer(const Duration(seconds: 3), () {
      newImageTimerCallback();
    });
  }

  void cancelTimers() {
    _mainImageTimer.cancel();
    _newImageTimer.cancel();
  }
}
