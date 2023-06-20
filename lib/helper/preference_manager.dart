import 'package:shared_preferences/shared_preferences.dart';

final preferenceManager = PreferenceManager();

/// Keys
const String firstDayOfWeekKey = 'first';
const String lastDayOfWeekKey = 'last';
const String _kLanguageKey = 'locale_key';

class PreferenceManager {
  static SharedPreferences? _preferenceManager;

  init() async {
    if (_preferenceManager == null) {
      _preferenceManager = await SharedPreferences.getInstance();
    }
  }

  String get language => _preferenceManager?.getString(_kLanguageKey) ?? 'bn';

  set language(String locale) =>
      _preferenceManager!.setString(_kLanguageKey, (locale));

  void setAdhkarProgress({required var key, required double progress}) =>
      _preferenceManager!.setDouble('adhkar_${key}_key', progress);

  double adhkarProgress({required var key}) =>
      (_preferenceManager?.getDouble('adhkar_${key}_key') ?? 0.0);

  void setReadItem({required var key, required DateTime value}) =>
      _preferenceManager!.setString('item_${key}_key', value.toIso8601String());

  DateTime? getReadItem({required var key}) =>
      (_preferenceManager?.getString('item_${key}_key') ?? null) == null
          ? null
          : DateTime.parse(
              _preferenceManager?.getString('item_${key}_key') ?? '0');

  void setWeekday({required var key, required DateTime value}) =>
      _preferenceManager?.setString(
          'weekday_${key}_key', value.toIso8601String());

  DateTime? getWeekday({required var key}) =>
      (_preferenceManager?.getString('weekday_${key}_key') ?? null) == null
          ? null
          : DateTime.parse(
              _preferenceManager!.getString('weekday_${key}_key') ?? '0');
}
