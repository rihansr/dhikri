import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhikri/values/styles.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? centerTitle;
  final Color? background;
  final Brightness? brightness;
  final TextStyle? fontStyle;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final IconData? leadingIcon;
  final Widget? leadingWidget;
  final IconData? trailingIcon;
  final Widget? trailingWidget;
  final Color? iconTint;
  final double? iconSize;
  final double? elevation;
  final Function()? onTapLeading;
  final Function()? onTapTrailing;

  const AppBarWidget({
    super.key,
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
  Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: AutoSizeText(
        title ?? '',
        minFontSize: (fontSize ?? 22) - 2,
        overflow: TextOverflow.ellipsis,
        style: fontStyle ??
            style.headlineTitleStyle.copyWith(
              fontSize: fontSize ?? 22,
              fontWeight: fontWeight ?? FontWeight.w700,
              color: fontColor ?? Colors.white,
            ),
      ),
      leading: leadingIcon != null || leadingWidget != null
          ? InkWell(
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () => onTapLeading == null
                  ? Navigator.pop(context)
                  : onTapLeading?.call(),
              child: leadingWidget ??
                  Icon(
                    leadingIcon,
                    size: iconSize ?? 24,
                    color: iconTint ?? Colors.white,
                  ),
            )
          : Container(),
      backgroundColor: background ?? Colors.transparent,
      elevation: elevation,
      actions: [
        trailingIcon != null || trailingWidget != null
            ? IconButton(
                onPressed: onTapTrailing,
                padding: const EdgeInsets.all(16),
                icon: trailingWidget ??
                    Icon(
                      trailingIcon,
                      size: iconSize ?? 22,
                      color: iconTint ?? Colors.white,
                    ),
              )
            : Container(),
      ],
    );
  }
}
