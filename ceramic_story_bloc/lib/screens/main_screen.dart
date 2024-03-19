import 'package:ceramic_story/bloc/company_story/company_story_bloc.dart';
import 'package:ceramic_story/bloc/company_story/company_story_event.dart';
import 'package:ceramic_story/repository/repository.dart';
import 'package:ceramic_story/screens/company_story_line_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../bloc/company_story/company_story_states.dart';
import '../main.dart';
import '../providers/app_language.dart';
import '../utils/localization.dart';
import '../utils/theme_notifier.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreen();
  }
}

class _MainScreen extends State<MainScreen> {
  late ThemeNotifier _themeNotifier;
  late AppLanguage _appLanguage;
  bool _isDark = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeNotifier = Provider.of<ThemeNotifier>(context);
    _appLanguage = Provider.of<AppLanguage>(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CompanyStoryBloc>(
          create: (BuildContext context) => CompanyStoryBloc(Repository()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _themeNotifier.getTheme(),
        home: Scaffold(
          appBar: AppBar(actions: [
            GestureDetector(
                onTap: () {
                  _appLanguage.changeLanguage(
                      _appLanguage.appLocal == Locale('hi', '') ?
                          Locale('en', '') : Locale('hi', '')
                  );
                  onThemeChanged(_isDark, _themeNotifier);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                      !_isDark ? Icons.dark_mode : Icons.dark_mode_outlined),
                )),
          ], title: Image.asset('assets/images/ic_icon.png', height: 40)),
          body: Container(
            padding: EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Expanded(child: companyStoryList(context))],
            ),
          ),
        ),
      ),
    );
  }

  Widget companyStoryList(BuildContext _context) {
    return BlocProvider(
      create: (context) {
        return CompanyStoryBloc(Repository())..add(LoadCompanyStoryEvent());
      },
      child: BlocBuilder<CompanyStoryBloc, CompanyStoryState>(
        builder: (context, state) {
          if (state is CompanyStoryLoadingState)
            return Center(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(strokeWidth: 3),
                SizedBox(width: 15),
                Text(
                  AppLocalizations.of(_context)!.translate('loading'),
                  style: _themeNotifier.textMedium(),
                )
              ],
            ));

          if (state is CompanyStoryErrorState)
            return Center(
                child: Text(
              'Error',
              style: _themeNotifier.getTheme(),
            ));

          if (state is CompanyStoryLoadedState) {
            return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (_, index) {
                  var companyStory = state.users[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(_context,
                          new MaterialPageRoute(builder: (context) {
                        return CompanyStoryLineScreen(companyStory);
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                          title: Text(
                              '${companyStory.storyHeading}' +
                                  AppLocalizations.of(_context)!
                                      .translate('loading'),
                              style: _themeNotifier.textMedium())),
                    ),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    _isDark = !value;
  }
}
