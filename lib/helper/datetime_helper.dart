import 'package:dhikri/helper/preference_manager.dart';

final dateTimeHelper = DateTimeHelper.function;

class DateTimeHelper {
  static DateTimeHelper get function => DateTimeHelper._();
  DateTimeHelper._();

  DateTime get now => DateTime.now();

  DateTime get today => DateTime(now.year, now.month, now.day);

  DateTime day({int days = 0}) =>
      DateTime(now.year, now.month, now.day).add(Duration(days: days));

  int get weekday => today.weekday;

  DateTime get lastWeek => today.subtract(const Duration(days: 7));

  DateTime get nextWeek => today.add(const Duration(days: 7));

  DateTime get firstDayOfWeek =>
      day(days: 2).subtract(Duration(days: day(days: 2).weekday + 1));

  DateTime get lastDayOfWeek => day(days: 2)
      .add(Duration(days: DateTime.daysPerWeek - (day(days: 2).weekday + 1)))
      .subtract(const Duration(microseconds: 1));

  bool itsANewWeek({DateTime? start, DateTime? end}) {
    start = start ?? preferenceManager.getWeekday(key: firstDayOfWeekKey);
    end = end ?? preferenceManager.getWeekday(key: lastDayOfWeekKey);
    return !isDateContain(start, end, today);
  }

  bool dateInThisWeek(
      {DateTime? start, DateTime? end, required DateTime? date}) {
    start = start ?? preferenceManager.getWeekday(key: firstDayOfWeekKey);
    end = end ?? preferenceManager.getWeekday(key: lastDayOfWeekKey);
    return isDateContain(start, end, date);
  }

  bool itsToday({required DateTime? date}) {
    DateTime start = today;
    DateTime end = today
        .add(const Duration(days: 1))
        .subtract(const Duration(microseconds: 1));
    return isDateContain(start, end, date);
  }

  bool isDateContain(DateTime? start, DateTime? end, DateTime? date) {
    if (start == null || end == null || date == null) {
      return false;
    } else if (date.add(const Duration(microseconds: 1)).isAfter(start) &&
        date.isBefore(end)) {
      return true;
    } else {
      return false;
    }
  }

  bool isNotFutureWeekday({int? weekday, DateTime? date}) {
    if (weekday == null && date == null) return false;

    weekday = weekday ?? date!.weekday;

    switch (this.weekday) {
      case 1:
        return weekday == 6 || weekday == 7 || weekday == 1;
      case 2:
        return weekday == 6 || weekday == 7 || weekday == 1 || weekday == 2;
      case 3:
        return weekday == 6 ||
            weekday == 7 ||
            weekday == 1 ||
            weekday == 2 ||
            weekday == 3;
      case 4:
        return weekday == 6 ||
            weekday == 7 ||
            weekday == 1 ||
            weekday == 2 ||
            weekday == 3 ||
            weekday == 4;
      case 5:
        return weekday == 6 ||
            weekday == 7 ||
            weekday == 1 ||
            weekday == 2 ||
            weekday == 3 ||
            weekday == 4 ||
            weekday == 5;
      case 6:
        return weekday == 6;
      case 7:
        return weekday == 6 || weekday == 7;
      default:
        return false;
    }
  }
}
