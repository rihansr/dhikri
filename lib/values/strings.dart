import 'dart:async';

import 'package:dhikri/helper/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Str implements WidgetsLocalizations {
  const Str();

  static Str? current;

  static const GeneratedLocalizationsDelegate delegate =
      GeneratedLocalizationsDelegate();

  static Str? of(BuildContext context) =>
      Localizations.of<Str>(navigator.context, Str);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  /// Titles
  String get appName => "যিকরি";
  String get websiteName => "The Grateful Servants";
  String get progress => 'অগ্রগতি';
  String get settings => 'সেটিংস';

  /// Labels
  String get language => 'ভাষা';
  String get currentLanguage => 'বাংলা';

  /// Drawer Items
  String get drawerAllDuas => 'সকল দুআ';
  String get drawerMasala => 'যিকর সংক্রান্ত মাসআলা';
  String get drawerSettings => 'সেটিংস';
  String get drawerAboutUs => 'আমাদের সম্পর্কে';
  String get drawerExit => 'প্রস্থান';
  String get copyright => '২০২১ © যিকরি';

  /// Adhkar Items
  String get pronounce => 'উচ্চারণঃ';
  String get meaning => 'অর্থঃ';

  /// Dhikr related Mas'ala
  String get masala =>
      "•\tসকালের যিকর সুবহে সাদিক থেকে শুরু করে। সূর্যোদয় পর্যন্ত পড়া উত্তম। অন্যথায় দুপুরের সালাতের আগ পর্যন্ত পড়া যায় বলে উলামাগণ মত দিয়েছেন।"
      "\n\n•\tবিকালের যিকর আসরের পর থেকে মাগরিব পর্যন্ত পড়া উত্তম। অন্যথায় মাগরিবের পর। পড়তেও বাধা নেই।"
      "\n\n•\tঅন্য কাজের ফাঁকে সকাল বিকালের এই যিকর গুলাে করা যাবে।"
      "\n\n•\tওদু বা মহিলাদের মাথায় কাপড় না থাকলেও এই যিকরগুলাে করতে বাধা নেই।"
      "\n\n•\tমাসিক ও প্রসব পরবর্তী স্রাব চলাকালীন অবস্থাতে বা গােসল ফরয় অবস্থাতেও যিকরগুলাে করা যাবে বলে গ্রহণযােগ্য উলামাগণ মত দিয়েছেন৷"
      "\n\nসর্বোপরি আল্লাহ তা'আলাই ভালাে জানেন।";

  @override
  String get reorderItemDown => throw UnimplementedError();

  @override
  String get reorderItemLeft => throw UnimplementedError();

  @override
  String get reorderItemRight => throw UnimplementedError();

  @override
  String get reorderItemToEnd => throw UnimplementedError();

  @override
  String get reorderItemToStart => throw UnimplementedError();

  @override
  String get reorderItemUp => throw UnimplementedError();
}

class $en extends Str {
  const $en();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  /// Titles
  @override
  String get appName => "Dhikri";
  @override
  String get websiteName => "The Grateful Servants";
  @override
  String get progress => 'Progress';

  /// Labels
  @override
  String get language => 'Language';
  @override
  String get currentLanguage => 'English';

  /// Drawer Items
  @override
  String get drawerAllDuas => 'All Dua';
  @override
  String get drawerMasala => "Dhikr related Mas'ala";
  @override
  String get drawerSettings => 'Settings';
  @override
  String get drawerAboutUs => 'About Us';
  @override
  String get drawerExit => 'Exit';
  @override
  String get copyright => '2021 © Dhikri';

  /// Azkar Items
  @override
  String get pronounce => 'Pronounce:';
  @override
  String get meaning => 'Meaning:';

  /// Dhikr related Mas'ala
  @override
  String get masala =>
      "-\tThe time of Morning Dhikr starts from early dawn, continuing it till the sunrise. However, one can continue it till the salah of dhuhr according to many scholars."
      "\n\n-\tThe dikhr of afternoon is better to be conducted after salah of asr till maghrib. However, there is no issue doing it after maghrib."
      "\n\n-\tThese Dhikr can be performed in the leisure of morning and evening duties (worldly)."
      "\n\n-\tThere is no prohibition of performing such dhikr for women without ablution (wudhu) or headcover."
      "\n\n-\tThe dhikr can be performed during the menstrual cycle or postpartum or even in states of impurity (when ghusl is obligatory) according to the opinion of most scholars."
      "\n\nAbove all, Allah knows the best.";
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<Str?> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale('bn', ''),
      Locale('en', ''),
    ];
  }

  LocaleListResolutionCallback listResolution(
      {Locale? fallback, bool withCountry = true}) {
    return (List<Locale>? locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported, withCountry);
      }
    };
  }

  LocaleResolutionCallback resolution(
      {Locale? fallback, bool withCountry = true}) {
    return (Locale? locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported, withCountry);
    };
  }

  @override
  Future<Str?> load(Locale locale) {
    final String? lang = getLang(locale);
    switch (lang) {
      case 'en':
        Str.current = const $en();
        return SynchronousFuture<Str?>(Str.current);
      default:
    }
    Str.current = const Str();
    return SynchronousFuture<Str?>(Str.current);
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;

  /// Internal method to resolve a locale from a list of locales.
  Locale _resolve(Locale? locale, Locale? fallback, Iterable<Locale> supported,
      bool withCountry) {
    if (locale == null || !_isSupported(locale, withCountry)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  /// Returns true if the specified locale is supported, false otherwise.
  bool _isSupported(Locale locale, bool withCountry) {
    for (Locale supportedLocale in supportedLocales) {
      /// Language must always match both locales.
      if (supportedLocale.languageCode != locale.languageCode) {
        continue;
      }

      /// If country code matches, return this locale.
      if (supportedLocale.countryCode == locale.countryCode) {
        return true;
      }

      /// If no country requirement is requested, check if this locale has no country.
      if (true != withCountry &&
          (supportedLocale.countryCode == null ||
              supportedLocale.countryCode!.isEmpty)) {
        return true;
      }
    }
    return false;
  }
}

String? getLang(Locale locale) =>
    locale.countryCode != null && locale.countryCode!.isEmpty
        ? locale.languageCode
        : locale.toString();
