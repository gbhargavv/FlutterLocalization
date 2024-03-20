import 'package:flutter/material.dart';
import 'package:flutter_localization/localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'app_language.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLanguage()..fetchLocale()),
      ],
      child: Consumer<AppLanguage>(
        builder: (context, value, child) {
          return MaterialApp(
            home: HomePage(),
            supportedLocales: [
              Locale('en', ''),
              Locale('hi', ''),
              Locale('ar', ''),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: value.appLocal,
            debugShowCheckedModeBanner: false,
            localeResolutionCallback: (locale, supportedLocales) =>
                // Check if the current device locale is supported
                supportedLocales.firstWhere(
                    (supportedLocale) =>
                        supportedLocale.languageCode == locale?.languageCode,
                    orElse: () => supportedLocales.first),
          );
        },
      ),
    );
  }
}