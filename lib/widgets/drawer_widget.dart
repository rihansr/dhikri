import 'dart:io';
import 'package:dhikri/blocs/home_bloc.dart';
import 'package:dhikri/pages/about_page.dart';
import 'package:dhikri/pages/masala_page.dart';
import 'package:dhikri/pages/settings_page.dart';
import 'package:dhikri/routes/routes.dart';
import 'package:dhikri/values/drawables.dart';
import 'package:dhikri/values/strings.dart';
import 'package:dhikri/values/styles.dart';
import 'package:dhikri/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerWidget extends StatelessWidget {
  final HomeBloc? bloc;
  final Gradient? backgroundColor;
  final Color? contentColor;
  const DrawerWidget({
    Key? key,
    this.bloc,
    this.backgroundColor,
    this.contentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.75,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: backgroundColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(1.0, 0.0), //(x,y)
            blurRadius: 16,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: ListView(
                children: [
                  DrawerItem(
                    icon: drawable.drawerDuaIcon,
                    label: Str.of(context).drawerAllDuas,
                    contentColor: contentColor,
                    onTap: () => Navigator.of(context).pushNamed(
                      Routes.itemsPage,
                      arguments: [bloc, bloc!.allDuas],
                    ),
                  ),
                  DrawerItem(
                    icon: drawable.drawerMasalaIcon,
                    label: Str.of(context).drawerMasala,
                    contentColor: contentColor,
                    onTap: () => showFullScreenDialog(
                      context: context,
                      child: const MasalaPage(),
                    ),
                  ),
                  DrawerItem(
                    icon: drawable.drawerSettingsIcon,
                    label: Str.of(context).drawerSettings,
                    contentColor: contentColor,
                    onTap: () => showFullScreenDialog(
                      context: context,
                      child: const SettingsPage(),
                    ),
                  ),
                  DrawerItem(
                    icon: drawable.drawerAboutUsIcon,
                    label: Str.of(context).drawerAboutUs,
                    contentColor: contentColor,
                    onTap: () => showFullScreenDialog(
                      context: context,
                      child: const AboutPage(),
                    ),
                  ),
                  DrawerItem(
                    icon: drawable.drawerExitIcon,
                    label: Str.of(context).drawerExit,
                    contentColor: contentColor,
                    onTap: () =>
                        Platform.isAndroid ? SystemNavigator.pop() : exit(0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              Str.of(context).copyright,
              textAlign: TextAlign.start,
              style: style.labelStyle.copyWith(
                color: contentColor,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String icon;
  final String label;
  final Function()? onTap;
  final Color? contentColor;
  const DrawerItem({
    Key? key,
    required this.icon,
    required this.label,
    this.onTap,
    this.contentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 0,
      onTap: () {
        Navigator.of(context).pop();
        onTap?.call();
      },
      leading: SvgPicture.asset(
        icon,
        colorFilter:
            ColorFilter.mode(contentColor ?? Colors.white, BlendMode.srcIn),
        height: 18,
        width: 18,
      ),
      title: Text(
        label,
        style: style.labelStyle.copyWith(
            color: contentColor ?? Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w300),
      ),
    );
  }
}
