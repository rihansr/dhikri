import 'dart:io';
import 'package:dhikri/blocs/home_bloc.dart';
import 'package:dhikri/pages/about_page.dart';
import 'package:dhikri/pages/masala_page.dart';
import 'package:dhikri/pages/settings_page.dart';
import 'package:dhikri/route_generator.dart';
import 'package:dhikri/values/dimens.dart';
import 'package:dhikri/values/drawables.dart';
import 'package:dhikri/values/strings.dart';
import 'package:dhikri/values/styles.dart';
import 'package:dhikri/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerWidget extends StatelessWidget {
  final HomeBloc bloc;
  final Gradient backgroundColor;
  final Color contentColor;
  const DrawerWidget({
    Key key,
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
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(1.0, 0.0), //(x,y)
            blurRadius: dimen.radius_16,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(dimen.padding_24, dimen.padding_32,
            dimen.padding_24, dimen.padding_16),
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
                      kItemsRoute,
                      arguments: [bloc, bloc.allDuas],
                    ),
                  ),
                  DrawerItem(
                    icon: drawable.drawerMasalaIcon,
                    label: Str.of(context).drawerMasala,
                    contentColor: contentColor,
                    onTap: () => showFullScreenDialog(
                      context: context,
                      child: MasalaPage(),
                    ),
                  ),
                  DrawerItem(
                    icon: drawable.drawerSettingsIcon,
                    label: Str.of(context).drawerSettings,
                    contentColor: contentColor,
                    onTap: () => showFullScreenDialog(
                      context: context,
                      child: SettingsPage(),
                    ),
                  ),
                  DrawerItem(
                    icon: drawable.drawerAboutUsIcon,
                    label: Str.of(context).drawerAboutUs,
                    contentColor: contentColor,
                    onTap: () => showFullScreenDialog(
                      context: context,
                      child: AboutPage(),
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
            SizedBox(height: dimen.margin_16),
            Text(
              Str.of(context).copyright,
              textAlign: TextAlign.start,
              style: style.labelStyle.copyWith(
                color: contentColor,
                fontSize: dimen.fontSize_12,
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
  final Function onTap;
  final Color contentColor;
  const DrawerItem({
    Key key,
    @required this.icon,
    @required this.label,
    this.onTap,
    this.contentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: dimen.padding_16),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          if (onTap != null) onTap();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: SvgPicture.asset(
                this.icon,
                color: contentColor ?? Colors.white,
                height: dimen.iconSize_18,
                width: dimen.iconSize_18,
              ),
            ),
            SizedBox(width: dimen.margin_16),
            Expanded(
              flex: 1,
              child: Text(
                this.label,
                style: style.labelStyle.copyWith(
                    color: contentColor ?? Colors.white,
                    fontSize: dimen.fontSize_15,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
