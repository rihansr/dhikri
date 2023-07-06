import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhikri/values/colors.dart';
import 'package:dhikri/values/strings.dart';
import 'package:dhikri/values/styles.dart';
import 'package:dhikri/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

class MasalaPage extends StatelessWidget {
  const MasalaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Str.of(context).drawerMasala,
        fontColor: color.disable,
        leadingIcon: Icons.arrow_back,
        iconTint: color.disable,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: AutoSizeText(
            Str.of(context).masala,
            style: style.headlineTitleStyle.copyWith(
              fontSize: 14,
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
