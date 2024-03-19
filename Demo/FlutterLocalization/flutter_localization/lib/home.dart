import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_language.dart';
import 'localization.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  late AppLanguage _appLanguage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLanguage = Provider.of<AppLanguage>(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!
              .translate('flutter_localization')
              .toString()),
          actions: [
            PopupMenuButton<dynamic>(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(child: Text('English'), value: 'en'),
                  PopupMenuItem(child: Text('Hindi'), value: 'hi'),
                  PopupMenuItem(child: Text('Arabic'), value: 'ar')
                ];
              },
              onSelected: (dynamic value) {
                _appLanguage.changeLanguage(Locale(value.toString(), ''));
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.translate('hello'),
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.translate('home_text'),
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
