import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhikri/utils/constants.dart';
import 'package:dhikri/utils/extensions.dart';
import 'package:dhikri/values/colors.dart';
import 'package:dhikri/values/dimens.dart';
import 'package:dhikri/values/drawables.dart';
import 'package:dhikri/values/strings.dart';
import 'package:dhikri/values/styles.dart';
import 'package:dhikri/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutPage extends StatelessWidget {
  final Function? callback;

  AboutPage({Key? key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Str.of(context)!.drawerAboutUs,
        fontColor: color.homeDisabledColor,
        leadingIcon: Icons.arrow_back,
        iconTint: color.homeDisabledColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        drawable.tgsLogo,
                        height: dimen.iconSize_128,
                        width: dimen.iconSize_128,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(dimen.margin_12,
                            dimen.margin_16, dimen.margin_12, dimen.margin_10),
                        child: AutoSizeText(
                          Str.current!.websiteName,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: style.headlineTitleStyle.copyWith(
                            fontSize: dimen.fontSize_20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ItemWidget(
                        icon: drawable.websiteIcon,
                        text: constant.website,
                        onTap: () => extension.openUrl(constant.website),
                      ),
                      ItemWidget(
                        icon: drawable.facebookIcon,
                        text: constant.facebook,
                        onTap: () => extension.openUrl(constant.facebook),
                      ),
                      ItemWidget(
                        icon: drawable.contactIcon,
                        text: constant.contact,
                        onTap: () => extension.launchCaller(constant.contact),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: dimen.padding_12, bottom: dimen.padding_24),
              child: Text(
                Str.of(context)!.copyright,
                textAlign: TextAlign.center,
                style: style.labelStyle.copyWith(
                  color: Colors.white,
                  fontSize: dimen.fontSize_13,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final String? icon;
  final String? text;
  final Function? onTap;

  const ItemWidget({
    Key? key,
    this.icon,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: dimen.margin_6, horizontal: dimen.margin_12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(right: dimen.margin_8),
              padding: EdgeInsets.all(dimen.padding_4),
              decoration: BoxDecoration(
                  color: color.homeDisabledColor.withOpacity(.75),
                  borderRadius: BorderRadius.all(
                    Radius.circular(dimen.radius_16),
                  )),
              child: SvgPicture.asset(
                this.icon!,
                theme: SvgTheme(
                  currentColor: color.homePrimaryColor,
                ),
                height: dimen.iconSize_10,
                width: dimen.iconSize_10,
              ),
            ),
            AutoSizeText(
              this.text ?? '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: style.headlineTitleStyle.copyWith(
                fontSize: dimen.fontSize_13,
                fontWeight: FontWeight.w400,
                color: color.homeDisabledColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
