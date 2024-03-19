import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('en', '');

  Locale get appLocal => _appLocale;

  void fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.getString('language_code') == null) {
      _appLocale = Locale('en', '');
    }
    _appLocale = Locale(prefs.getString('language_code').toString());
    notifyListeners();
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale('hi', '')) {
      _appLocale = Locale('hi', '');
      await prefs.setString('language_code', 'hi');
    } else if (type == Locale('ar', '')) {
      _appLocale = Locale('ar', '');
      await prefs.setString('language_code', 'ar');
    } else {
      _appLocale = Locale('en', '');
      await prefs.setString('language_code', 'en');
    }
    notifyListeners();
  }
}
