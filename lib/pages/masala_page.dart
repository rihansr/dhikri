import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhikri/values/colors.dart';
import 'package:dhikri/values/dimens.dart';
import 'package:dhikri/values/strings.dart';
import 'package:dhikri/values/styles.dart';
import 'package:dhikri/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MasalaPage extends StatelessWidget {
  final Function? callback;

  MasalaPage({Key? key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Str.of(context)!.drawerMasala,
        fontColor: color.homeDisabledColor,
        leadingIcon: Icons.arrow_back,
        iconTint: color.homeDisabledColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: dimen.padding_16, horizontal: dimen.padding_24),
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: AutoSizeText(
            Str.of(context)!.masala,
            style: style.headlineTitleStyle.copyWith(
              fontSize: dimen.fontSize_14,
              height: 1.5,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
