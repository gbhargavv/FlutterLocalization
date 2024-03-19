import 'package:ceramic_story/model/company_story.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class CompanyStoryEvent extends Equatable {
  const CompanyStoryEvent();
}

class LoadCompanyStoryEvent extends CompanyStoryEvent {
  @override
  List<CompanyStory> get props => [];
}