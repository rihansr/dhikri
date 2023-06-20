import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhikri/blocs/home_bloc.dart';
import 'package:dhikri/configs/settings.dart';
import 'package:dhikri/model/adhkar_model.dart';
import 'package:dhikri/route_generator.dart';
import 'package:dhikri/values/colors.dart';
import 'package:dhikri/values/dimens.dart';
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
          gradient: bloc.adhkar.background ?? color.homeScaffoldColor,
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
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        top: dimen.padding_12,
                        bottom: dimen.padding_24,
                      ),
                      itemCount: bloc.adhkar.items?.length ?? 0,
                      separatorBuilder: (_, i) {
                        return SizedBox(height: dimen.margin_24);
                      },
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (_, i) {
                        return ListWidget(
                          background: bloc.adhkar.itemsBackground,
                          item: bloc.adhkar.items![i],
                          onSelect: (item) async =>
                              bloc.itemDetails(context, item).then((listen) {
                            if (listen)
                              Navigator.of(context).pushNamed(
                                kDetailsRoute,
                                arguments: [bloc, i, item],
                              );
                          }),
                        );
                      },
                    )
                  : GridView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(
                        dimen.padding_12,
                        dimen.padding_12,
                        dimen.padding_12,
                        dimen.padding_40,
                      ),
                      shrinkWrap: true,
                      itemCount: bloc.adhkar.items?.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: dimen.margin_6,
                          mainAxisSpacing: dimen.margin_8,
                          childAspectRatio: .8),
                      itemBuilder: (_, i) {
                        return GridWidget(
                          background: bloc.adhkar.itemsBackground,
                          item: bloc.adhkar.items![i],
                          onSelect: (item) async =>
                              bloc.itemDetails(context, item).then((listen) {
                            if (listen)
                              Navigator.of(context).pushNamed(
                                kDetailsRoute,
                                arguments: [bloc.adhkar, i, item],
                              );
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

  ListWidget({
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
    return GestureDetector(
      onTap: () {
        if (onSelect != null) onSelect!(this.item);
      },
      child: Container(
        margin: EdgeInsets.only(left: dimen.margin_16, right: dimen.margin_32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              item!.read! ? Icons.check_circle : Icons.radio_button_unchecked,
              color: this.background,
            ),
            SizedBox(width: dimen.margin_4),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: this.background ?? Colors.transparent,
                    borderRadius:
                        BorderRadius.all(Radius.circular(dimen.radius_48))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (hasIcon)
                      SvgPicture.asset(
                        item?.icon ?? '',
                        height: dimen.iconSize_80,
                        width: dimen.iconSize_80,
                      ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          hasIcon ? dimen.padding_4 : dimen.padding_16,
                          hasIcon ? dimen.padding_4 : dimen.padding_12,
                          dimen.padding_16,
                          hasIcon ? dimen.padding_4 : dimen.padding_12,
                        ),
                        child: AutoSizeText(
                          title,
                          textAlign: TextAlign.center,
                          minFontSize: dimen.fontSize_14,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: style.titleStyle
                              .copyWith(fontSize: dimen.fontSize_15),
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

  GridWidget({
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
    return GestureDetector(
      onTap: () {
        if (onSelect != null) onSelect!(this.item);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: dimen.padding_10, vertical: dimen.padding_10),
        decoration: BoxDecoration(
            color: this.background ?? Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(dimen.radius_20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: SvgPicture.asset(
                item?.icon ?? '',
              ),
            ),
            SizedBox(height: dimen.margin_4),
            AutoSizeText(
              title,
              textAlign: TextAlign.center,
              minFontSize: dimen.fontSize_12,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: style.titleStyle.copyWith(fontSize: dimen.fontSize_13),
            )
          ],
        ),
      ),
    );
  }
}
