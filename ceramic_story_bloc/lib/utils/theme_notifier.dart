import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  textMedium() => _themeData.textTheme.titleMedium;

  textSmall() => _themeData.textTheme.titleSmall;

  textLarge() => _themeData.textTheme.titleLarge;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}

final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white),
    brightness: Brightness.dark,
    textTheme: TextTheme(
        titleSmall: TextStyle(color: Colors.white, fontSize: 12),
        titleMedium: TextStyle(color: Colors.white, fontSize: 14),
        titleLarge: TextStyle(color: Colors.white, fontSize: 16)),
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.blue,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black)));

final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.blue),
    primaryColor: Colors.white,
    brightness: Brightness.light,
    textTheme: TextTheme(
        titleSmall: TextStyle(color: Colors.black, fontSize: 12),
        titleMedium: TextStyle(color: Colors.black, fontSize: 14),
        titleLarge: TextStyle(color: Colors.black, fontSize: 16)),
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white)));
