import 'package:auto_size_text/auto_size_text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:dhikri/configs/settings.dart';
import 'package:dhikri/values/colors.dart';
import 'package:dhikri/values/dimens.dart';
import 'package:dhikri/values/strings.dart';
import 'package:dhikri/values/styles.dart';
import 'package:dhikri/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SettingsPage extends StatelessWidget {
  final Function callback;

  SettingsPage({Key key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Str.of(context).drawerSettings,
        fontColor: color.homeDisabledColor,
        leadingIcon: Icons.arrow_back,
        iconTint: color.homeDisabledColor,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SettingsItem(
              title: Str.of(context).language,
              subtitle: Str.of(context).currentLanguage,
              leading: CommunityMaterialIcons.translate,
              value: settings.currentLocale.value.languageCode == 'bn',
              callback: (value) => settings.setLocale(value),
            )
          ],
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData leading;
  final dynamic value;
  final Function(dynamic) callback;

  const SettingsItem({
    Key key,
    this.callback,
    this.title,
    this.subtitle,
    this.leading,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(
        left: dimen.padding_8,
        right: dimen.padding_12,
      ),
      leading: IconButton(
        icon: Icon(
          this.leading,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      title: AutoSizeText(
        this.title ?? '',
        style: style.titleStyle.copyWith(
          color: Colors.white,
        ),
      ),
      subtitle: AutoSizeText(
        this.subtitle,
        style: style.titleStyle.copyWith(
          color: color.homeDisabledColor,
          fontSize: dimen.fontSize_12,
        ),
      ),
      trailing: CupertinoSwitch(
        value: this.value,
        trackColor: color.homeDisabledColor.withOpacity(.25),
        onChanged: (value) {
          if (callback != null) callback(value);
        },
      ),
    );
  }
}
