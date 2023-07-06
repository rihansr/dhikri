import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhikri/utils/constants.dart';
import 'package:dhikri/utils/extensions.dart';
import 'package:dhikri/values/colors.dart';
import 'package:dhikri/values/drawables.dart';
import 'package:dhikri/values/strings.dart';
import 'package:dhikri/values/styles.dart';
import 'package:dhikri/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Str.of(context).drawerAboutUs,
        fontColor: color.disable,
        leadingIcon: Icons.arrow_back,
        iconTint: color.disable,
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
                        height: 128,
                        width: 128,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 16, 12, 10),
                        child: AutoSizeText(
                          Str.of(context).websiteName,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: style.headlineTitleStyle.copyWith(
                            fontSize: 20,
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
              padding: const EdgeInsets.only(top: 12, bottom: 24),
              child: Text(
                Str.of(context).copyright,
                textAlign: TextAlign.center,
                style: style.labelStyle.copyWith(
                  color: Colors.white,
                  fontSize: 13,
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
  final Function()? onTap;

  const ItemWidget({
    Key? key,
    this.icon,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: color.disable.withOpacity(.75),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              child: SvgPicture.asset(
                icon!,
                colorFilter: ColorFilter.mode(color.primary, BlendMode.srcIn),
                height: 10,
                width: 10,
              ),
            ),
            AutoSizeText(
              text ?? '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: style.headlineTitleStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: color.disable,
              ),
            )
          ],
        ),
      ),
    );
  }
}
