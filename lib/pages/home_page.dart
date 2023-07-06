import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhikri/blocs/home_bloc.dart';
import 'package:dhikri/configs/settings.dart';
import 'package:dhikri/model/adhkar_model.dart';
import 'package:dhikri/model/weekday_model.dart';
import 'package:dhikri/routes/routes.dart';
import 'package:dhikri/values/colors.dart';
import 'package:dhikri/values/strings.dart';
import 'package:dhikri/values/styles.dart';
import 'package:dhikri/widgets/appbar_widget.dart';
import 'package:dhikri/widgets/base_widget.dart';
import 'package:dhikri/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeBloc>(
      model: Provider.of<HomeBloc>(context),
      onInit: (bloc) => bloc.init(),
      builder: (context, bloc, child) => Container(
        decoration: BoxDecoration(
          gradient: color.scaffold,
        ),
        child: Scaffold(
          key: _key,
          appBar: AppBarWidget(
            title: Str.of(context).appName,
            fontSize: 36,
            fontWeight: FontWeight.w900,
            fontColor: color.disable,
            leadingIcon: Icons.menu,
            iconTint: color.disable,
            onTapLeading: () => _key.currentState!.openDrawer(),
          ),
          drawer: DrawerWidget(
            bloc: bloc,
            backgroundColor: color.scaffold,
            contentColor: color.disable,
          ),
          drawerScrimColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(12, 12, 12, 0.0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.disable,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Str.of(context).appName,
                        textAlign: TextAlign.center,
                        style: style.titleStyle.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (Weekday day in bloc.weekdays)
                            WeekdayWidget(
                              weekDay: day,
                              onCheck: (weekday) => bloc.setReadToday(weekday),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: bloc.adhkars.length,
                      separatorBuilder: (_, i) {
                        return const SizedBox(height: 12);
                      },
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (_, i) {
                        return AdhkarWidget(
                          adhkar: bloc.adhkars[i],
                          onSelect: (azkar) => Navigator.of(context).pushNamed(
                            Routes.itemsPage,
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
    );
  }
}

class WeekdayWidget extends StatelessWidget {
  const WeekdayWidget({
    Key? key,
    required this.weekDay,
    this.onCheck,
  }) : super(key: key);

  final Weekday weekDay;
  final Function(Weekday)? onCheck;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        if (onCheck != null) onCheck!(weekDay);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 9,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeText(
              settings.isBangla ? weekDay.dayBn ?? '' : weekDay.dayEn ?? '',
              minFontSize: 14,
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
                    ? color.secondary.withOpacity(.25)
                    : weekDay.status!
                        ? color.enable
                        : Colors.red,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              margin: const EdgeInsets.only(top: 6),
              padding: const EdgeInsets.all(2),
              child: weekDay.status == null
                  ? const SizedBox(
                      height: 14,
                      width: 14,
                    )
                  : Icon(
                      weekDay.status! ? Icons.check : Icons.clear,
                      color: color.disable,
                      size: 14,
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class AdhkarWidget extends StatelessWidget {
  final Adhkar? adhkar;
  final Function(Adhkar?)? onSelect;

  const AdhkarWidget({
    Key? key,
    this.adhkar,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => onSelect?.call(adhkar),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              adhkar?.backdrop ?? '',
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
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
                      minFontSize: 18,
                      style: style.headlineTitleStyle
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 20),
                  LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width / 2,
                    animation: true,
                    animationDuration: 500,
                    lineHeight: 8,
                    percent: (adhkar?.progress?.round() ?? 0) / 100,
                    padding: EdgeInsets.zero,
                    barRadius: const Radius.circular(8),
                    backgroundColor: color.disable,
                    progressColor: color.enable,
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
