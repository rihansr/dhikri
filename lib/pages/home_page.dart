import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhikri/blocs/home_bloc.dart';
import 'package:dhikri/configs/settings.dart';
import 'package:dhikri/model/adhkar_model.dart';
import 'package:dhikri/model/weekday_model.dart';
import 'package:dhikri/route_generator.dart';
import 'package:dhikri/values/colors.dart';
import 'package:dhikri/values/dimens.dart';
import 'package:dhikri/values/strings.dart';
import 'package:dhikri/values/styles.dart';
import 'package:dhikri/widgets/appbar_widget.dart';
import 'package:dhikri/widgets/base_widget.dart';
import 'package:dhikri/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeBloc>(
      controller: HomeBloc(data: Provider.of(context)),
      onReady: (bloc) {
        bloc.init();
      },
      builder: (context, bloc, child) => Container(
        decoration: BoxDecoration(
          gradient: color.homeScaffoldColor,
        ),
        child: Scaffold(
          key: _key,
          appBar: AppBarWidget(
            title: Str.of(context).appName,
            fontSize: dimen.fontSize_36,
            fontWeight: FontWeight.w900,
            fontColor: color.homeDisabledColor,
            leadingIcon: Icons.menu,
            iconTint: color.homeDisabledColor,
            onTapLeading: () => _key.currentState.openDrawer(),
          ),
          drawer: DrawerWidget(
            bloc: bloc,
            backgroundColor: color.homeScaffoldColor,
            contentColor: color.homeDisabledColor,
          ),
          drawerScrimColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      dimen.margin_12,
                      dimen.margin_12,
                      dimen.margin_12,
                      0.0,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: dimen.padding_12,
                      vertical: dimen.padding_6,
                    ),
                    decoration: BoxDecoration(
                      color: color.homeDisabledColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(dimen.radius_12),
                        bottomLeft: Radius.circular(dimen.radius_24),
                        bottomRight: Radius.circular(dimen.radius_12),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          Str.of(context).progress,
                          textAlign: TextAlign.center,
                          style: style.titleStyle.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: dimen.fontSize_20,
                          ),
                        ),
                        SizedBox(height: dimen.margin_8),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            for (Weekday day in bloc.weekdays)
                              WeekdayWidget(
                                weekDay: day,
                                onCheck: (weekday) =>
                                    bloc.setReadToday(weekday),
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: dimen.margin_2),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: ListView.separated(
                        padding: EdgeInsets.only(
                          top: dimen.padding_12,
                          bottom: dimen.padding_12,
                        ),
                        physics: BouncingScrollPhysics(),
                        itemCount: bloc?.adhkars?.length ?? 0,
                        separatorBuilder: (_, i) {
                          return SizedBox(height: dimen.margin_12);
                        },
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (_, i) {
                          return AdhkarWidget(
                            adhkar: bloc.adhkars[i] ?? Adhkar(),
                            onSelect: (azkar) =>
                                Navigator.of(context).pushNamed(
                              kItemsRoute,
                              arguments: [bloc, azkar],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WeekdayWidget extends StatelessWidget {
  const WeekdayWidget({
    Key key,
    @required this.weekDay,
    this.onCheck,
  }) : super(key: key);

  final Weekday weekDay;
  final Function(Weekday) onCheck;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onCheck != null) onCheck(this.weekDay);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 9,
        margin: EdgeInsets.symmetric(
            vertical: dimen.margin_4, horizontal: dimen.margin_2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeText(
              settings.isBangla ? weekDay?.dayBn ?? '' : weekDay?.dayEn ?? '',
              minFontSize: dimen.fontSize_14,
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: style.labelStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: weekDay.status == null
                    ? color.homeSecondaryColor.withOpacity(.25)
                    : weekDay.status
                        ? color.homeEnabledColor
                        : Colors.red,
                borderRadius:
                    BorderRadius.all(Radius.circular(dimen.radius_16)),
              ),
              child: weekDay.status == null
                  ? SizedBox(
                      height: dimen.iconSize_14,
                      width: dimen.iconSize_14,
                    )
                  : Icon(
                      weekDay.status ? Icons.check : Icons.clear,
                      color: color.homeDisabledColor,
                      size: dimen.iconSize_14,
                    ),
              margin: EdgeInsets.only(top: dimen.margin_6),
              padding: EdgeInsets.all(dimen.padding_2),
            )
          ],
        ),
      ),
    );
  }
}

class AdhkarWidget extends StatelessWidget {
  final Adhkar adhkar;
  final Function(Adhkar) onSelect;

  const AdhkarWidget({
    Key key,
    this.adhkar,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onSelect != null) onSelect(this.adhkar);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: dimen.margin_24),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              adhkar?.backdrop ?? '',
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: EdgeInsets.all(dimen.padding_16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: AutoSizeText(
                      settings.isBangla
                          ? adhkar?.titleBn ?? ''
                          : adhkar?.titleEn ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      minFontSize: dimen.fontSize_18,
                      style: style.headlineTitleStyle
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: dimen.margin_20),
                  LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width / 2,
                    animation: true,
                    animationDuration: 500,
                    lineHeight: dimen.viewHeight_8,
                    percent: (adhkar?.progress?.round() ?? 0) / 100,
                    padding: EdgeInsets.zero,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    backgroundColor: color.homeDisabledColor,
                    progressColor: color.homeEnabledColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
