import 'package:ceramic_story/model/company_story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../bloc/company_story_line/company_story_line_bloc.dart';
import '../bloc/company_story_line/company_story_line_event.dart';
import '../bloc/company_story_line/company_story_line_states.dart';
import '../providers/app_language.dart';
import '../repository/repository.dart';
import '../utils/localization.dart';
import '../utils/theme_notifier.dart';

class CompanyStoryLineScreen extends StatefulWidget {
  CompanyStoryLineScreen(this.companyStory);

  CompanyStory companyStory;

  @override
  State<StatefulWidget> createState() {
    return _CompanyStoryLineScreen();
  }
}

class _CompanyStoryLineScreen extends State<CompanyStoryLineScreen> {
  late ThemeNotifier _themeNotifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeNotifier = Provider.of<ThemeNotifier>(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CompanyStoryLineBloc>(
            create: (BuildContext context) =>
                CompanyStoryLineBloc(Repository(), widget.companyStory),
          ),
        ],
        child: SafeArea(
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: _themeNotifier.getTheme(),
                home: Scaffold(
                  body: Container(
                    padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Expanded(child: companyStoryList(context))],
                    ),
                  ),
                ))));
  }

  Widget companyStoryList(BuildContext _context) {
    return BlocProvider(
      create: (context) {
        return CompanyStoryLineBloc(Repository(), widget.companyStory)
          ..add(LoadCompanyStoryLineEvent());
      },
      child: BlocBuilder<CompanyStoryLineBloc, CompanyStoryLineState>(
        builder: (context, state) {
          if (state is CompanyStoryLineLoadingState)
            return Center(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 15),
                Text(
                  AppLocalizations.of(_context)!
                      .translate('loading')
                      .toString(),
                  style: _themeNotifier.textMedium(),
                )
              ],
            ));

          if (state is CompanyStoryLineErrorState)
            return Center(
                child: Text(
              'Error',
              style: TextStyle(color: Colors.red),
            ));

          if (state is CompanyStoryLineLoadedState) {
            return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (_, index) {
                  var companyStory = state.users[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                          title: Text(
                        '${companyStory.storylineText}',
                        style: _themeNotifier.textMedium(),
                      )),
                    ),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
