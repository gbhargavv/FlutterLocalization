import 'package:ceramic_story/model/company_story.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class CompanyStoryState extends Equatable {}

// data loading state
class CompanyStoryLoadingState extends CompanyStoryState {
  @override
  List<CompanyStory> get props => [];
}

// data loaded state
class CompanyStoryLoadedState extends CompanyStoryState {
  final List<CompanyStory> users;

  CompanyStoryLoadedState(this.users);

  @override
  List<Object?> get props => [users];
}

// data loading error state
class CompanyStoryErrorState extends CompanyStoryState {
  final String error;

  CompanyStoryErrorState(this.error);

  @override
  List<Object?> get props => [error];
}