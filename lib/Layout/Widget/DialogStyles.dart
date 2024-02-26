import 'package:flutter/material.dart';
import '../Style/styleapp.dart';
import 'ButtonStyles.dart';

class RegularAcceptedDialog extends StatelessWidget {
  final String header;
  final String description;
  final String acceptedText;
  final String loadingAcceptedText;
  final TextStyle? headerTextStyle;
  final TextStyle? descriptionTextStyle;
  final Icon icon;
  final Color iconColor;
  final double iconSize;
  final Function() acceptedOnTap;

  const RegularAcceptedDialog({
    super.key,
    this.header = 'Warning',
    required this.description,
    this.acceptedText = 'OK',
    this.loadingAcceptedText = 'Processing',
    this.headerTextStyle,
    this.descriptionTextStyle,
    this.icon = const Icon(Icons.warning),
    this.iconColor = Colors.red,
    this.iconSize = 40,
    required this.acceptedOnTap,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Color labelColor = themeData.brightness == Brightness.light ? Colors.black : Colors.white;
    Color containerColor = themeData.brightness == Brightness.light ? Colors.grey.shade200 : Colors.grey.shade800;

    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    header,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: headerTextStyle ?? StyleApp.largeTextStyle.copyWith(color: labelColor, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Icon(
                      icon.icon,
                      color: iconColor,
                      size: iconSize,
                    ),
                  ),
                  Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    style: descriptionTextStyle ?? StyleApp.mediumTextStyle.copyWith(color: labelColor),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Flexible(
                      child: AnimateProgressButton(
                        labelButton: acceptedText,
                        labelButtonStyle: StyleApp.mediumTextStyle.copyWith(
                            fontWeight: FontWeight.w900,
                            color: labelColor
                        ),
                        labelProgress: loadingAcceptedText,
                        height: 40,
                        margin: const EdgeInsets.all(5),
                        containerColor: Colors.blue.shade700,
                        containerRadius: 10,
                        onTap: () async {
                          acceptedOnTap();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegularDialog extends StatelessWidget {
  final String header;
  final String description;
  final String declinedText;
  final String acceptedText;
  final String loadingDeclinedText;
  final String loadingAcceptedText;
  final TextStyle? headerTextStyle;
  final TextStyle? descriptionTextStyle;
  final Icon icon;
  final Color iconColor;
  final double iconSize;
  final Function() declinedOnTap;
  final Function() acceptedOnTap;

  const RegularDialog({
    super.key,
    this.header = 'Warning',
    required this.description,
    this.declinedText = 'Cancel',
    this.acceptedText = 'OK',
    this.loadingDeclinedText = 'Back to App',
    this.loadingAcceptedText = 'Processing',
    this.headerTextStyle,
    this.descriptionTextStyle,
    this.icon = const Icon(Icons.warning),
    this.iconColor = Colors.red,
    this.iconSize = 40,
    required this.declinedOnTap,
    required this.acceptedOnTap,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Color labelColor = themeData.brightness == Brightness.light ? Colors.black : Colors.white;
    Color containerColor = themeData.brightness == Brightness.light ? Colors.grey.shade200 : Colors.grey.shade800;

    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    header,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: headerTextStyle ?? StyleApp.largeTextStyle.copyWith(color: labelColor, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Icon(
                      icon.icon,
                      color: iconColor,
                      size: iconSize,
                    ),
                  ),
                  Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    style: descriptionTextStyle ?? StyleApp.mediumTextStyle.copyWith(color: labelColor),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Flexible(
                        child: AnimateProgressButton(
                          labelButton: declinedText,
                          labelButtonStyle: StyleApp.mediumTextStyle.copyWith(
                              fontWeight: FontWeight.w900,
                              color: labelColor
                          ),
                          labelProgress: loadingDeclinedText,
                          height: 40,
                          margin: const EdgeInsets.all(5),
                          containerColor: Colors.blue.shade700,
                          containerRadius: 10,
                          onTap: () async {
                            declinedOnTap();
                          },
                        ),
                      ),
                      Flexible(
                        child: AnimateProgressButton(
                          labelButton: acceptedText,
                          labelButtonStyle: StyleApp.mediumTextStyle.copyWith(
                              fontWeight: FontWeight.w900,
                              color: labelColor
                          ),
                          labelProgress: loadingAcceptedText,
                          height: 40,
                          margin: const EdgeInsets.all(5),
                          containerColor: Colors.red.shade700,
                          containerRadius: 10,
                          onTap: () async {
                            acceptedOnTap();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
