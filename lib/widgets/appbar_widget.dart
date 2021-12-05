import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhikri/values/dimens.dart';
import 'package:dhikri/values/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class AppBarWidget extends PreferredSize {
  final String title;
  final bool centerTitle;
  final Color background;
  final Brightness brightness;
  final TextStyle fontStyle;
  final Color fontColor;
  final FontWeight fontWeight;
  final double fontSize;
  final IconData leadingIcon;
  final Widget leadingWidget;
  final IconData trailingIcon;
  final Widget trailingWidget;
  final Color iconTint;
  final double iconSize;
  final double elevation;
  final Function onTapLeading;
  final Function onTapTrailing;

  AppBarWidget({
    this.title,
    this.centerTitle = true,
    this.background,
    this.brightness,
    this.fontStyle,
    this.fontColor,
    this.fontWeight,
    this.fontSize,
    this.leadingIcon,
    this.leadingWidget,
    this.trailingIcon,
    this.trailingWidget,
    this.iconTint,
    this.iconSize,
    this.elevation = 0,
    this.onTapLeading,
    this.onTapTrailing,
  });

  @override
  Size get preferredSize => Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: this.brightness ?? Brightness.dark,
      centerTitle: this.centerTitle,
      title: AutoSizeText(
        this.title ?? '',
        minFontSize: (this.fontSize ?? dimen.fontSize_22) - 2,
        overflow: TextOverflow.ellipsis,
        style: this.fontStyle ??
            style.headlineTitleStyle.copyWith(
              fontSize: this.fontSize ?? dimen.fontSize_22,
              fontWeight: this.fontWeight ?? FontWeight.w700,
              color: this.fontColor ?? Colors.white,
            ),
      ),
      leading: this.leadingIcon != null || this.leadingWidget != null
          ? InkWell(
              onTap: () {
                if (this.onTapLeading == null)
                  Navigator.pop(context);
                else
                  this.onTapLeading();
              },
              child: this.leadingWidget ??
                  Icon(
                    this.leadingIcon,
                    size: this.iconSize ?? dimen.iconSize_24,
                    color: this.iconTint ?? Colors.white,
                  ),
            )
          : Container(),
      backgroundColor: this.background ?? Colors.transparent,
      elevation: this.elevation,
      actions: [
        this.trailingIcon != null || this.trailingWidget != null
            ? InkWell(
                onTap: this.onTapTrailing,
                child: this.trailingWidget ??
                    Icon(
                      this.trailingIcon,
                      size: this.iconSize ?? dimen.iconSize_24,
                      color: this.iconTint ?? Colors.white,
                    ),
              )
            : Container(),
      ],
    );
  }
}
