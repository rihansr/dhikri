import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhikri/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CustomDialog extends StatelessWidget {
  final double width;
  final String title;
  final EdgeInsets padding;
  final TextAlign titleAlign;
  final TextStyle titleFontStyle;
  final Color titleFontColor;
  final double titleFontSize;
  final String subtitle;
  final TextAlign subtitleAlign;
  final TextStyle subtitleFontStyle;
  final Color subtitleFontColor;
  final double subtitleFontSize;
  final String negativeButtonTitle;
  final String positiveButtonTitle;
  final TextStyle buttonFontStyle;
  final Color buttonFontColor;
  final double buttonFontSize;
  final Axis buttonDirection;
  final Color buttonBackground;
  final Function onNegativeButtonClicked;
  final Function onPositiveButtonClicked;

  const CustomDialog({
    Key key,
    this.width,
    this.title,
    this.padding,
    this.titleAlign,
    this.titleFontStyle,
    this.titleFontColor,
    this.titleFontSize = 18.0,
    this.subtitle,
    this.subtitleAlign,
    this.subtitleFontStyle,
    this.subtitleFontColor,
    this.subtitleFontSize = 15.0,
    this.negativeButtonTitle,
    this.positiveButtonTitle,
    this.buttonFontStyle,
    this.buttonFontColor,
    this.buttonFontSize = 20.0,
    this.buttonDirection = Axis.vertical,
    this.buttonBackground,
    this.onNegativeButtonClicked,
    this.onPositiveButtonClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.0),
      ),
      color: Colors.white,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width / 1.15,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.clear,
                    color: Color(0xFF888888),
                  ),
                ),
              ),
            ),
            if (title?.isNotEmpty ?? false)
              Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: AutoSizeText(
                  title,
                  textAlign: titleAlign ?? TextAlign.center,
                  minFontSize: (titleFontSize - 2),
                  style: titleFontStyle ??
                      TextStyle(
                        fontSize: titleFontSize,
                        color: titleFontColor ?? color.homePrimaryColor,
                        fontWeight: FontWeight.normal,
                        letterSpacing: .48,
                      ),
                ),
              ),
            if (subtitle?.isNotEmpty ?? false)
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: AutoSizeText(
                  subtitle,
                  minFontSize: subtitleFontSize - 1,
                  textAlign: subtitleAlign ?? TextAlign.start,
                  style: subtitleFontStyle ??
                      TextStyle(
                        fontSize: subtitleFontSize,
                        color: subtitleFontColor ?? color.homeSecondaryColor,
                        fontWeight: FontWeight.normal,
                        letterSpacing: .48,
                      ),
                ),
              ),
            if (buttonDirection == Axis.horizontal)
              Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (negativeButtonTitle?.isNotEmpty ?? false)
                      Expanded(
                        flex: 1,
                        child: actionButton(context, negativeButtonTitle,
                            onNegativeButtonClicked),
                      ),
                    if (positiveButtonTitle?.isNotEmpty ?? false)
                      Expanded(
                        flex: 1,
                        child: actionButton(context, positiveButtonTitle,
                            onPositiveButtonClicked),
                      ),
                  ],
                ),
              ),
            if (buttonDirection == Axis.vertical)
              Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (positiveButtonTitle?.isNotEmpty ?? false)
                      actionButton(context, positiveButtonTitle,
                          onPositiveButtonClicked),
                    if (negativeButtonTitle?.isNotEmpty ?? false)
                      actionButton(context, negativeButtonTitle,
                          onNegativeButtonClicked),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget actionButton(BuildContext context, String label, Function function) {
    return Container(
      decoration: BoxDecoration(
        color: buttonBackground ?? Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextButton(
        child: AutoSizeText(
          label,
          minFontSize: buttonFontSize,
          style: buttonFontStyle ??
              TextStyle(
                fontSize: buttonFontSize,
                color: buttonFontColor ?? color.homePrimaryColor,
                fontWeight: FontWeight.normal,
                letterSpacing: .48,
              ),
        ),
        onPressed: () async {
          Navigator.of(context).pop();
          if (function != null) function();
        },
      ),
    );
  }
}

showFullScreenDialog({
  @required BuildContext context,
  @required Widget child,
  LinearGradient background,
  bool dismissible = true,
  bool isLightTheme = true,
}) {
  return showDialog(
    barrierDismissible: dismissible,
    barrierColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      if (isLightTheme)
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ));
      return StatefulBuilder(
        builder: (context, setState) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(dismissible);
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: background ?? color.homeScaffoldColor,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: child,
            ),
          );
        },
      );
    },
  ).then((val) {
    if (isLightTheme)
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ));
  });
}

Future<void> showDialogBox(
    {BuildContext context, Widget child, bool dismissible = true}) {
  return showGeneralDialog(
    context: context,
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
        scale: a1.value,
        child: Opacity(
            opacity: a1.value,
            child: WillPopScope(
              onWillPop: () {
                return Future(() => false);
              },
              child: Center(
                child: child == null ? Container() : child,
              ),
            )),
      );
    },
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return null;
    },
    barrierDismissible: dismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black26,
    transitionDuration: const Duration(milliseconds: 200),
  );
}
