import 'package:dhikri/helper/preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

final settings = Settings.value;

class Settings {
  static Settings get value => Settings._();
  Settings._();

  ValueNotifier<Locale> currentLocale =
      new ValueNotifier(Locale(preferenceManager.language, ''));

  bool get isBangla => currentLocale.value.languageCode == 'bn';

  void setLocale(bool isChecked) {
    preferenceManager.language = isChecked ? 'bn' : 'en';
    currentLocale.value = new Locale(preferenceManager.language, '');
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    currentLocale.notifyListeners();
  }
}
