import 'package:flutter/material.dart';
import '../Style/styleapp.dart';

class ProgressButton extends StatefulWidget {
  final String labelButton;
  final String labelProgress;
  final EdgeInsets? margin;
  final EdgeInsets? marginButtonLabel;
  final double? width;
  final double? height;
  final Color containerColor;
  final double containerOpacity;
  final double containerRadius;
  final Color? borderColor;
  final double borderOpacity;
  final double borderRadius;
  final double borderSize;
  final TextAlign textAlign;
  final TextStyle? labelButtonStyle;
  final Function onTap;
  final Icon? icon;

  ProgressButton({
    this.labelButton = 'Click Here',
    this.labelProgress = 'Loading',
    this.margin,
    this.marginButtonLabel,
    this.width,
    this.height,
    this.containerColor = Colors.blue,
    this.containerOpacity = 1.0,
    this.containerRadius = 0,
    this.borderColor,
    this.borderOpacity = 1.0,
    this.borderRadius = 0,
    this.borderSize = 1,
    this.textAlign = TextAlign.center,
    this.labelButtonStyle,
    required this.onTap,
    this.icon,
  });

  @override
  _ProgressButtonState createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Color labelColor = themeData.brightness == Brightness.light ? Colors.black : Colors.white;

    return GestureDetector(
      onTap: () async {
        if (!_loading) {
          setState(() {
            _loading = true;
          });

          await Future.delayed(const Duration(seconds: 1));
          bool success = await widget.onTap();

          setState(() {
            _loading = false;
          });

          if (success == false) {
            return;
          }
        }
      },
      child: Container(
        margin: widget.margin,
        width: widget.width,
        height: widget.height,
        constraints: const BoxConstraints(minHeight: 30),
        decoration: BoxDecoration(
          color: widget.containerColor.withOpacity(widget.containerOpacity),
          borderRadius: BorderRadius.circular(widget.containerRadius),
          border: Border.all(
            color: widget.borderColor?.withOpacity(widget.borderOpacity) ?? Colors.transparent,
            width: widget.borderSize,
          ),
        ),
        child: Padding(
          padding: widget.marginButtonLabel ?? EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_loading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              if (_loading)
                const SizedBox(width: 10),
              if (!_loading)
                widget.icon ?? Container(),
              if (!_loading)
                const SizedBox(width: 10),
              Flexible(
                child: Text(
                  _loading ? widget.labelProgress ?? '' : widget.labelButton,
                  textAlign: widget.textAlign,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: widget.labelButtonStyle ?? StyleApp.largeTextStyle.copyWith(color: labelColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimateProgressButton extends StatefulWidget {
  final String labelButton;
  final String labelProgress;
  final EdgeInsets? margin;
  final EdgeInsets? marginButtonLabel;
  final double? width;
  final double? height;
  final Color containerColor;
  final Color containerColorStart;
  final Color containerColorEnd;
  final double containerOpacity;
  final double containerRadius;
  final Color? borderColor;
  final double borderOpacity;
  final double borderRadius;
  final double borderSize;
  final double xPosition;
  final double yPosition;
  final TextAlign textAlign;
  final TextStyle? labelButtonStyle;
  final Function onTap;
  final Icon? icon;

  AnimateProgressButton({
    this.labelButton = 'Click Here',
    this.labelProgress = 'Loading',
    this.margin,
    this.marginButtonLabel,
    this.width,
    this.height,
    this.containerColor = Colors.blue,
    this.containerColorStart = Colors.transparent,
    this.containerColorEnd = Colors.transparent,
    this.containerOpacity = 1.0,
    this.containerRadius = 0,
    this.borderColor,
    this.borderOpacity = 1.0,
    this.borderRadius = 0,
    this.borderSize = 1,
    this.xPosition = 0.0,
    this.yPosition = -5.0,
    this.textAlign = TextAlign.center,
    this.labelButtonStyle,
    required this.onTap,
    this.icon,
  });

  @override
  _AnimateProgressButtonState createState() => _AnimateProgressButtonState();
}

class _AnimateProgressButtonState extends State<AnimateProgressButton> with SingleTickerProviderStateMixin {
  bool _loading = false;
  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _positionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(_controller!);
    _positionAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(widget.xPosition, widget.yPosition)).animate(_controller!);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Color labelColor = themeData.brightness == Brightness.light ? Colors.black : Colors.white;

    return GestureDetector(
      onTap: () async {
        if (!_loading) {
          setState(() {
            _loading = true;
          });

          await Future.delayed(const Duration(milliseconds: 300));
          bool success = await widget.onTap();
          _controller!.reverse();

          _controller!.forward();
          await Future.delayed(const Duration(milliseconds: 600));
          _controller!.reverse();

          setState(() {
            _loading = false;
          });

          if (success == false) {
            return;
          }
        }
      },

      child: Container(
        margin: widget.margin,
        width: widget.width,
        height: widget.height,
        constraints: const BoxConstraints(minHeight: 30),
        decoration: BoxDecoration(
          gradient: (widget.containerColorStart != Colors.transparent && widget.containerColorEnd != Colors.transparent)
              ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [widget.containerColorStart, widget.containerColorEnd],
          )
              : null,
          color: (widget.containerColorStart == Colors.transparent || widget.containerColorEnd == Colors.transparent)
              ? widget.containerColor.withOpacity(widget.containerOpacity)
              : null,
          borderRadius: BorderRadius.circular(widget.containerRadius),
          border: Border.all(
            color: widget.borderColor?.withOpacity(widget.borderOpacity) ?? Colors.transparent,
            width: widget.borderSize,
          ),
        ),
        child: Padding(
          padding: widget.marginButtonLabel ?? EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_loading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              if (_loading)
                const SizedBox(width: 10),
              if (!_loading)
                AnimatedBuilder(
                  animation: _controller!,
                  builder: (BuildContext context, Widget? child) {
                    return Opacity(
                      opacity: _opacityAnimation!.value,
                      child: Transform.translate(
                        offset: _positionAnimation!.value,
                        child: child,
                      ),
                    );
                  },
                  child: widget.icon ?? Container(),
                ),
              if (!_loading && widget.icon != null)
                const SizedBox(width: 10),
                Flexible(
                  child: AnimatedBuilder(
                    animation: _controller!,
                    builder: (BuildContext context, Widget? child) {
                      return Opacity(
                        opacity: _opacityAnimation!.value,
                        child: Transform.translate(
                          offset: _positionAnimation!.value,
                          child: Text(
                            _loading ? widget.labelProgress ?? "" : widget.labelButton,
                            textAlign: widget.textAlign,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: widget.labelButtonStyle ?? StyleApp.largeTextStyle.copyWith(color: labelColor),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimateMenuButton extends StatefulWidget {
  final String labelButton;
  final String labelProgress;
  final EdgeInsets? margin;
  final EdgeInsets? marginButtonLabel;
  final double? width;
  final double? height;
  final Color containerColorStart;
  final Color containerColorEnd;
  final double containerOpacity;
  final double containerRadius;
  final Color? borderColor;
  final double borderOpacity;
  final double borderRadius;
  final double borderSize;
  final double xPosition;
  final double yPosition;
  final TextAlign textAlign;
  final TextStyle? labelButtonStyle;
  final Function onTap;
  final Icon? icon;

  AnimateMenuButton({
    this.labelButton = 'Click Here',
    this.labelProgress = 'Loading',
    this.margin,
    this.marginButtonLabel,
    this.width,
    this.height,
    this.containerColorStart = Colors.red,
    this.containerColorEnd = Colors.blue,
    this.containerOpacity = 1.0,
    this.containerRadius = 0,
    this.borderColor,
    this.borderOpacity = 1.0,
    this.borderRadius = 0,
    this.borderSize = 1,
    this.xPosition = 0.0,
    this.yPosition = -5.0,
    this.textAlign = TextAlign.center,
    this.labelButtonStyle,
    required this.onTap,
    this.icon,
  });

  @override
  _AnimateMenuButtonState createState() => _AnimateMenuButtonState();
}

class _AnimateMenuButtonState  extends State<AnimateMenuButton> with SingleTickerProviderStateMixin {
  bool _loading = false;
  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _positionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(_controller!);
    _positionAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(widget.xPosition, widget.yPosition)).animate(_controller!);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Color labelColor = themeData.brightness == Brightness.light ? Colors.black : Colors.white;

    return GestureDetector(
      onTap: () async {
        if (!_loading) {
          setState(() {
            _loading = true;
          });

          await Future.delayed(const Duration(milliseconds: 300));
          bool success = await widget.onTap();
          _controller!.reverse();

          _controller!.forward();
          await Future.delayed(const Duration(milliseconds: 600));
          _controller!.reverse();

          setState(() {
            _loading = false;
          });

          if (success == false) {
            return;
          }
        }
      },

      child: Container(
        margin: widget.margin,
        width: widget.width,
        height: widget.height,
        constraints: const BoxConstraints(minHeight: 50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [widget.containerColorStart, widget.containerColorEnd],
          ),
          borderRadius: BorderRadius.circular(widget.containerRadius),
          border: Border.all(
            color: widget.borderColor?.withOpacity(widget.borderOpacity) ?? Colors.transparent,
            width: widget.borderSize,
          ),
        ),
        child: Padding(
          padding: widget.marginButtonLabel ?? EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_loading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              if (_loading)
                const SizedBox(height: 10),
              if (!_loading)
                AnimatedBuilder(
                  animation: _controller!,
                  builder: (BuildContext context, Widget? child) {
                    return Opacity(
                      opacity: _opacityAnimation!.value,
                      child: Transform.translate(
                        offset: _positionAnimation!.value,
                        child: child,
                      ),
                    );
                  },
                  child: widget.icon ?? Container(),
                ),
              if (!_loading && widget.icon != null)
                const SizedBox(height: 10),
              Flexible(
                child: AnimatedBuilder(
                  animation: _controller!,
                  builder: (BuildContext context, Widget? child) {
                    return Opacity(
                      opacity: _opacityAnimation!.value,
                      child: Transform.translate(
                        offset: _positionAnimation!.value,
                        child: Text(
                          _loading ? widget.labelProgress ?? "" : widget.labelButton,
                          textAlign: widget.textAlign,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: widget.labelButtonStyle ?? StyleApp.mediumTextStyle.copyWith(color: labelColor),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
