import 'dart:collection';
import 'package:dhikri/blocs/base_bloc.dart';
import 'package:dhikri/configs/settings.dart';
import 'package:dhikri/data.dart';
import 'package:dhikri/helper/datetime_helper.dart';
import 'package:dhikri/helper/preference_manager.dart';
import 'package:dhikri/model/adhkar_model.dart';
import 'package:dhikri/model/weekday_model.dart';
import 'package:dhikri/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_share/flutter_share.dart';

class HomeBloc extends BaseBloc {
  void init() {
    if (dateTimeHelper.itsANewWeek()) {
      preferenceManager.setWeekday(
          key: firstDayOfWeekKey, value: dateTimeHelper.firstDayOfWeek);
      preferenceManager.setWeekday(
          key: lastDayOfWeekKey, value: dateTimeHelper.lastDayOfWeek);
    }

    setWeekdays();
    updateWeekdayProgress();

    setAdhkars();
    updateAzkarProgress();
  }

  /// Weekdays
  List<Weekday> _weekdays = [];
  UnmodifiableListView<Weekday> get weekdays => UnmodifiableListView(_weekdays);

  void setWeekdays() {
    _weekdays = local.weekdays;
    notifyListeners();
  }

  updateWeekdayProgress() {
    for (int i = 0; i < _weekdays.length; i++) {
      Weekday weekday = _weekdays[i];

      bool _isWeekdayAllowed =
          dateTimeHelper.isNotFutureWeekday(weekday: weekday.id);
      bool _dateInThisWeek = dateTimeHelper.dateInThisWeek(
          date: preferenceManager.getWeekday(key: weekday.id));
      bool _itsToday = weekday.id == dateTimeHelper.weekday;

      _weekdays[i].status = _isWeekdayAllowed
          ? _dateInThisWeek
              ? true
              : _itsToday
                  ? null
                  : false
          : null;
    }

    notifyListeners();
  }

  void setReadToday(Weekday weekday) {
    if (!dateTimeHelper.isNotFutureWeekday(weekday: weekday.id)) return;
    bool _itsToday = weekday.id == dateTimeHelper.weekday;

    for (int i = 0; i < _weekdays.length; i++) {
      Weekday _weekday = _weekdays[i];
      if (_weekday == weekday) {
        bool isChecked = _weekdays[i].status ?? false;
        preferenceManager.setWeekday(
          key: _weekday.id,
          value: isChecked ? dateTimeHelper.lastWeek : dateTimeHelper.today,
        );
        _weekdays[i].status = isChecked
            ? _itsToday
                ? null
                : false
            : true;
        break;
      }
    }

    notifyListeners();
  }

  /// Adhkars
  List<Adhkar> _adhkars = [];
  UnmodifiableListView<Adhkar> get adhkars => UnmodifiableListView(_adhkars);

  void setAdhkars() {
    _allDuas = local.allDuas;
    _adhkars = local.adhkars;
    notifyListeners();
  }

  updateAzkarProgress() {
    for (Adhkar adhkar in _adhkars) {
      bool readToday = dateTimeHelper.itsToday(
          date: preferenceManager.getReadItem(key: '${adhkar.id}'));
      double progress =
          readToday ? preferenceManager.adhkarProgress(key: adhkar.id) : 0;
      _adhkars[adhkar.id! - 1].progress = progress;
    }
    notifyListeners();
  }

  void makeProgress({required int adhkarId, required int? itemId}) {
    if (adhkarId == 0) return;

    Adhkar adhkar = _adhkars[adhkarId - 1];
    if (!adhkar.weekdays!.contains(dateTimeHelper.weekday)) return;

    preferenceManager.setReadItem(
        key: '${adhkarId}_$itemId', value: dateTimeHelper.today);

    double progress = 0.0;

    for (int i = 0; i < (adhkar.items?.length ?? 0); i++) {
      AdhkarItem item = adhkar.items![i];
      bool readToday = dateTimeHelper.itsToday(
          date: preferenceManager.getReadItem(key: '${adhkar.id}_${item.id}'));
      if (readToday) {
        _adhkars[adhkarId - 1].items![i].read = true;
        int itemPos = _allDuas.items!.indexOf(item);
        if (itemPos != -1) _allDuas.items![itemPos].read = true;
        progress = progress + (100 / (adhkar.items?.length ?? 1));
      }
    }

    if (progress > 0) {
      preferenceManager.setAdhkarProgress(key: adhkar.id, progress: progress);

      preferenceManager.setReadItem(
          key: '${adhkar.id}', value: dateTimeHelper.today);

      _adhkars[adhkar.id! - 1].progress = progress;
    }

    notifyListeners();
  }

  /// All Duas
  Adhkar _allDuas = Adhkar();
  Adhkar get allDuas => _allDuas;
  set allDuas(azkar) => _allDuas = azkar;

  ///Selected Adhkar
  Adhkar _adhkar = Adhkar();
  Adhkar get adhkar => _adhkar;
  set adhkar(azkar) => _adhkar = azkar;

  Future<bool> itemDetails(BuildContext context, AdhkarItem? item) async {
    for (int azkarId in item?.adhkarIds ?? []) {
      makeProgress(adhkarId: azkarId, itemId: item?.id);
    }

    if (item?.detailEn == null && item?.detailBn == null)
      return false;
    else {
      return true;
    }
  }

  /// Item Details
  ScrollController scrollController = ScrollController();

  int? _itemPos;
  int? get itemPos => _itemPos;
  set itemPos(position) => _itemPos = position;

  AdhkarItem? _item = AdhkarItem();
  AdhkarItem? get item => _item;
  set item(adhkarItem) => _item = adhkarItem;

  String get title =>
      settings.isBangla ? _item?.titleBn ?? '' : _item?.titleEn ?? '';

  Detail get detail => settings.isBangla
      ? _item?.detailBn ?? Detail()
      : _item?.detailEn ?? Detail();

  Future<void> share() async => await FlutterShare.share(
        title: title,
        text: buildText(),
        chooserTitle: title,
      );

  String? buildText() {
    var itemDetails = StringBuffer();
    if (title.isNotEmpty) itemDetails.write('\n$title\n');

    if (detail.title?.isNotEmpty ?? false)
      itemDetails.write('\n${detail.title}\n');

    if (detail.times?.isNotEmpty ?? false)
      itemDetails.write('\n${detail.times}\n');

    for (Verse verse in detail.verses ?? []) {
      var verseDetails = StringBuffer();

      if (verse.title?.isNotEmpty ?? false)
        verseDetails.write('\n${verse.title}\n');

      if (verse.times?.isNotEmpty ?? false)
        verseDetails.write('\n${verse.times}\n');

      if (verse.arabic?.isNotEmpty ?? false)
        verseDetails.write('\n${verse.arabic}\n');

      if (verse.pronounce?.isNotEmpty ?? false)
        verseDetails.write('\n${Str.current!.pronounce} ${verse.pronounce}\n');

      if (verse.meaning?.isNotEmpty ?? false)
        verseDetails.write('\n${Str.current!.meaning} ${verse.meaning}\n');

      if (verseDetails.toString().isNotEmpty)
        itemDetails.write('${verseDetails.toString()}\n');
    }

    if (detail.source?.isNotEmpty ?? false)
      itemDetails.write('${detail.source}\n');

    if (detail.explanation?.isNotEmpty ?? false)
      itemDetails.write('\n${detail.explanation}');

    return (itemDetails.toString().isNotEmpty) ? itemDetails.toString() : null;
  }

  Future<bool> previous() async {
    int curPos = _itemPos!;
    int prePos = curPos - 1;
    if (prePos >= 0) {
      AdhkarItem item = _adhkar.items![prePos];
      if (item.detailEn == null && item.detailBn == null) return false;
      scrollController.jumpTo(scrollController.position.minScrollExtent);
      this.itemPos = prePos;
      this.item = item;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> next() async {
    int curPos = _itemPos!;
    int nextPos = curPos + 1;
    int total = _adhkar.items?.length ?? 0;
    if (nextPos < total) {
      AdhkarItem item = _adhkar.items![nextPos];
      if (item.detailEn == null && item.detailBn == null) return false;
      scrollController.jumpTo(scrollController.position.minScrollExtent);
      this.itemPos = nextPos;
      this.item = item;
      notifyListeners();
      return true;
    }
    return false;
  }
}
