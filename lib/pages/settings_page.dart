import 'package:auto_size_text/auto_size_text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:dhikri/configs/settings.dart';
import 'package:dhikri/values/colors.dart';
import 'package:dhikri/values/strings.dart';
import 'package:dhikri/values/styles.dart';
import 'package:dhikri/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Str.of(context).drawerSettings,
        fontColor: color.disable,
        leadingIcon: Icons.arrow_back,
        iconTint: color.disable,
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
  final String? title;
  final String? subtitle;
  final IconData? leading;
  final dynamic value;
  final Function(dynamic)? callback;

  const SettingsItem({
    Key? key,
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
      contentPadding: const EdgeInsets.only(left: 8, right: 12),
      leading: IconButton(
        icon: Icon(
          leading,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      title: AutoSizeText(
        title ?? '',
        style: style.titleStyle.copyWith(
          color: Colors.white,
        ),
      ),
      subtitle: AutoSizeText(
        subtitle!,
        style: style.titleStyle.copyWith(
          color: color.disable,
          fontSize: 12,
        ),
      ),
      trailing: CupertinoSwitch(
        value: value,
        trackColor: color.disable.withOpacity(.25),
        onChanged: (value) {
          if (callback != null) callback!(value);
        },
      ),
    );
  }
}
