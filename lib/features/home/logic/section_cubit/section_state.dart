part of 'section_cubit.dart';

abstract class SectionState {}

class SectionInitial extends SectionState {}

class SectionLoading extends SectionState {}

class SectionLoaded extends SectionState {
  final List<Map<String, dynamic>> sections;

  SectionLoaded(this.sections);
}

class SectionAdded extends SectionState {
  final int sectionId;

  SectionAdded(this.sectionId);
}

class SectionError extends SectionState {
  final String message;

  SectionError(this.message);
}
