import 'package:attendy/core/sqflite/attendy_sqflite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/section.dart';

part 'section_state.dart';

class SectionCubit extends Cubit<SectionState> {
  final AttendySqflite db;
  List<Section> sections = [];

  SectionCubit(this.db) : super(SectionInitial());

  Future<void> addSection(String name, String description) async {
    try {
      emit(SectionLoading());
      int sectionId = await db.insertSection(name, description);
      sections.add(
          Section(sectionId: sectionId, name: name, description: description));
      emit(SectionLoaded(sections));
    } catch (e) {
      emit(SectionError('Failed to add section: ${e.toString()}'));
    }
  }

  Future<void> fetchSections() async {
    try {
      emit(SectionLoading());
      sections = await db.getSections();
      emit(SectionLoaded(sections));
    } catch (e) {
      emit(SectionError('Failed to fetch sections: ${e.toString()}'));
    }
  }
}
