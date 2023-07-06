import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhikri/blocs/home_bloc.dart';
import 'package:dhikri/model/adhkar_model.dart';
import 'package:dhikri/values/colors.dart';
import 'package:dhikri/values/strings.dart';
import 'package:dhikri/values/styles.dart';
import 'package:dhikri/widgets/appbar_widget.dart';
import 'package:dhikri/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  final HomeBloc? homeBloc;
  final int? itemPos;
  final AdhkarItem? item;

  const DetailsPage({
    Key? key,
    this.homeBloc,
    this.itemPos,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeBloc>(
      model: Provider.of<HomeBloc>(context),
      onInit: (bloc) {
        bloc.itemPos = itemPos;
        bloc.item = item;
      },
      builder: (context, bloc, child) => Container(
        decoration: BoxDecoration(
          gradient: bloc.adhkar.background ?? color.scaffold,
        ),
        child: Scaffold(
          appBar: AppBarWidget(
            brightness: bloc.adhkar.brightness,
            leadingIcon: Icons.arrow_back,
            trailingIcon: Icons.share,
            onTapTrailing: () => bloc.share(),
            iconTint: bloc.adhkar.contentColor,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (bloc.title.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: AutoSizeText(
                      bloc.title,
                      textAlign: TextAlign.center,
                      style: style.titleStyle.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: SingleChildScrollView(
                      controller: bloc.scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (bloc.detail.verses?.isNotEmpty ?? false)
                            Container(
                              clipBehavior: Clip.antiAlias,
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (bloc.detail.title?.isNotEmpty ?? false)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: AutoSizeText(
                                        bloc.detail.title ?? '',
                                        minFontSize: 17,
                                        textAlign: TextAlign.center,
                                        style: style.textStyle.copyWith(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  if (bloc.detail.times?.isNotEmpty ?? false)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: AutoSizeText(
                                        bloc.detail.times ?? '',
                                        textAlign: TextAlign.center,
                                        style: style.textStyle.copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  if (bloc.detail.verses?.isNotEmpty ?? false)
                                    Column(
                                      children: [
                                        for (Verse verse
                                            in bloc.detail.verses ?? [])
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (verse.title?.isNotEmpty ??
                                                  false)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8),
                                                  child: AutoSizeText(
                                                    verse.title ?? '',
                                                    textAlign: TextAlign.center,
                                                    style: style.titleStyle
                                                        .copyWith(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              if (verse.times?.isNotEmpty ??
                                                  false)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8),
                                                  child: AutoSizeText(
                                                    verse.times ?? '',
                                                    textAlign: TextAlign.center,
                                                    style: style.textStyle
                                                        .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              if (verse.arabic?.isNotEmpty ??
                                                  false)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 12,
                                                    right: 12,
                                                    bottom: 16,
                                                  ),
                                                  child: AutoSizeText(
                                                    verse.arabic ?? '',
                                                    minFontSize: 20,
                                                    textAlign: TextAlign.center,
                                                    style: style.textStyle
                                                        .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              if (verse.pronounce?.isNotEmpty ??
                                                  false)
                                                Text(
                                                  Str.of(context).pronounce,
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      style.labelStyle.copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              if (verse.pronounce?.isNotEmpty ??
                                                  false)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6, bottom: 12),
                                                  child: AutoSizeText(
                                                    verse.pronounce ?? '',
                                                    textAlign: TextAlign.center,
                                                    style: style.textStyle
                                                        .copyWith(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              if (verse.meaning?.isNotEmpty ??
                                                  false)
                                                Text(
                                                  Str.of(context).meaning,
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      style.labelStyle.copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              if (verse.meaning?.isNotEmpty ??
                                                  false)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6, bottom: 32),
                                                  child: AutoSizeText(
                                                    verse.meaning ?? '',
                                                    textAlign: TextAlign.center,
                                                    style: style.textStyle
                                                        .copyWith(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                )
                                            ],
                                          )
                                      ],
                                    ),
                                  if (bloc.detail.source?.isNotEmpty ?? false)
                                    AutoSizeText(
                                      bloc.detail.source ?? '',
                                      minFontSize: 15,
                                      textAlign: TextAlign.center,
                                      style: style.textStyle.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          if (bloc.detail.explanation?.isNotEmpty ?? false)
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: AutoSizeText(
                                bloc.detail.explanation ?? '',
                                textAlign: TextAlign.center,
                                minFontSize: 15,
                                style: style.textStyle.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButtonWidget(
                  icon: Icons.arrow_back_ios_rounded,
                  onPressed: () => bloc.previous().then((listen) {
                    if (listen) {
                      bloc.itemDetails(context, bloc.item!);
                    }
                  }),
                ),
                IconButtonWidget(
                  icon: Icons.arrow_forward_ios_rounded,
                  onPressed: () => bloc.next().then((listen) {
                    if (listen) {
                      bloc.itemDetails(context, bloc.item!);
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      icon: Icon(icon, color: Colors.white70),
      onPressed: onPressed,
    );
  }
}
