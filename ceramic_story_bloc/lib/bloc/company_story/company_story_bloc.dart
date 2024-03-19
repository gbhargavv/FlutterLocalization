import 'package:ceramic_story/bloc/company_story/company_story_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/repository.dart';
import 'company_story_states.dart';

class CompanyStoryBloc extends Bloc<CompanyStoryEvent, CompanyStoryState> {
  final Repository _userRepository;

  CompanyStoryBloc(this._userRepository) : super(CompanyStoryLoadingState()) {
    on<LoadCompanyStoryEvent>((event, emit) async {
      emit(CompanyStoryLoadingState());
      try {
        final users = await _userRepository.getCompanyStory();
        emit(CompanyStoryLoadedState(users));
      } catch (e) {
        emit(CompanyStoryErrorState(e.toString()));
      }
    });
  }
}