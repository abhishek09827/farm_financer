import 'dart:ui';

import 'package:flutter/material.dart';

import 'lanf_en.dart';
import 'lang_hi.dart';
import 'languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {

  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar', 'hi'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageHi();
      case 'hi':
        return LanguageHi();
      default:
        return LanguageHi();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;

}