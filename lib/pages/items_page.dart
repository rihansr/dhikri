import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhikri/blocs/home_bloc.dart';
import 'package:dhikri/configs/settings.dart';
import 'package:dhikri/model/adhkar_model.dart';
import 'package:dhikri/routes/routes.dart';
import 'package:dhikri/values/colors.dart';
import 'package:dhikri/values/styles.dart';
import 'package:dhikri/widgets/appbar_widget.dart';
import 'package:dhikri/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ItemsPage extends StatelessWidget {
  final HomeBloc homeBloc;
  final Adhkar azkar;

  const ItemsPage({
    Key? key,
    required this.homeBloc,
    required this.azkar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeBloc>(
      model: Provider.of<HomeBloc>(context),
      onInit: (bloc) {
        bloc.adhkar = azkar;
      },
      builder: (context, bloc, child) => Container(
        decoration: BoxDecoration(
          gradient: bloc.adhkar.background ?? color.scaffold,
        ),
        child: SafeArea(
          child: Scaffold(
            appBar: AppBarWidget(
              brightness: bloc.adhkar.brightness,
              title: settings.isBangla
                  ? bloc.adhkar.titleBn ?? ''
                  : bloc.adhkar.titleEn ?? '',
              fontColor: bloc.adhkar.contentColor,
              leadingIcon: Icons.arrow_back,
              iconTint: bloc.adhkar.contentColor,
            ),
            body: Center(
              child: (bloc.adhkar.itemView ?? ItemsView.list) == ItemsView.list
                  ? ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(top: 12, bottom: 24),
                      itemCount: bloc.adhkar.items?.length ?? 0,
                      separatorBuilder: (_, i) {
                        return const SizedBox(height: 24);
                      },
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (_, i) {
                        return ListWidget(
                          background: bloc.adhkar.itemsBackground,
                          item: bloc.adhkar.items![i],
                          onSelect: (item) async =>
                              bloc.itemDetails(context, item).then((listen) {
                            if (listen) {
                              Navigator.of(context).pushNamed(
                                Routes.detailsPage,
                                arguments: [bloc, i, item],
                              );
                            }
                          }),
                        );
                      },
                    )
                  : GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(
                        12,
                        12,
                        12,
                        40,
                      ),
                      shrinkWrap: true,
                      itemCount: bloc.adhkar.items?.length ?? 0,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 8,
                              childAspectRatio: .8),
                      itemBuilder: (_, i) {
                        return GridWidget(
                          background: bloc.adhkar.itemsBackground,
                          item: bloc.adhkar.items![i],
                          onSelect: (item) async =>
                              bloc.itemDetails(context, item).then((listen) {
                            if (listen) {
                              Navigator.of(context).pushNamed(
                                Routes.detailsPage,
                                arguments: [bloc.adhkar, i, item],
                              );
                            }
                          }),
                        );
                      },
                      scrollDirection: Axis.vertical,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class ListWidget extends StatelessWidget {
  final Color? background;
  final AdhkarItem? item;
  final Function(AdhkarItem?)? onSelect;

  const ListWidget({
    Key? key,
    this.item,
    this.onSelect,
    this.background,
  }) : super(key: key);

  String get title =>
      settings.isBangla ? item?.titleBn ?? '' : item?.titleEn ?? '';

  bool get hasIcon => item?.icon?.isNotEmpty ?? false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        if (onSelect != null) onSelect!(item);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              item!.read! ? Icons.check_circle : Icons.radio_button_unchecked,
              color: background,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: background ?? Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(48))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (hasIcon)
                      SvgPicture.asset(
                        item?.icon ?? '',
                        height: 80,
                        width: 80,
                      ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          hasIcon ? 4 : 16,
                          hasIcon ? 4 : 12,
                          16,
                          hasIcon ? 4 : 12,
                        ),
                        child: AutoSizeText(
                          title,
                          textAlign: TextAlign.center,
                          minFontSize: 14,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: style.titleStyle.copyWith(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridWidget extends StatelessWidget {
  final Color? background;
  final AdhkarItem? item;
  final Function(AdhkarItem?)? onSelect;

  const GridWidget({
    Key? key,
    this.item,
    this.onSelect,
    this.background,
  }) : super(key: key);

  String get title =>
      settings.isBangla ? item?.titleBn ?? '' : item?.titleBn ?? '';

  bool get hasIcon => item?.icon?.isNotEmpty ?? false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        if (onSelect != null) onSelect!(item);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: background ?? Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: SvgPicture.asset(
                item?.icon ?? '',
              ),
            ),
            const SizedBox(height: 4),
            AutoSizeText(
              title,
              textAlign: TextAlign.center,
              minFontSize: 12,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: style.titleStyle.copyWith(fontSize: 13),
            )
          ],
        ),
      ),
    );
  }
}
