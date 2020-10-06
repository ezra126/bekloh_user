import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization{
  final Locale locale;

  AppLocalization(this.locale);
  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }
  Map<String,String> _localizedValues;
  Future load() async{
    var jsonStringValues=
    await rootBundle.loadString('lib/lang/${locale.languageCode}.json');
    var mappedJson= json.decode(jsonStringValues) as  Map<String, dynamic>;
    _localizedValues = mappedJson.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  String getTranslateValue(String key) {
    return _localizedValues[key];
  }
  static const LocalizationsDelegate<AppLocalization> delegate =
  _AppLocalizationDelegate();
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization>{
  const _AppLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en','am'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    var localizations = AppLocalization(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) {
    return false;
  }

}
