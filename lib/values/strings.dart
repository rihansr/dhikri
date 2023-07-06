import 'package:flutter/material.dart';
import 'package:dhikri/helper/navigation_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Str {
  const Str();

  static AppLocalizations of([BuildContext? context]) =>
      AppLocalizations.of(context ?? navigator.context)!;
}
