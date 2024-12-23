part of 'section_cubit.dart';

abstract class SectionState {}

class SectionInitial extends SectionState {}

class SectionLoading extends SectionState {}

class SectionLoaded extends SectionState {
  final List<Section> sections;

  SectionLoaded(this.sections);
}

class SectionError extends SectionState {
  final String message;

  SectionError(this.message);
}
