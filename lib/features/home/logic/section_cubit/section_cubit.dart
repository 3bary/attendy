import 'package:attendy/core/sqflite/attendy_sqflite.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'section_state.dart';

class SectionCubit extends Cubit<SectionState> {
  final AttendySqflite db;

  SectionCubit(this.db) : super(SectionInitial());

  // Add a new section
  Future<void> addSection(String name, String description) async {
    try {
      emit(SectionLoading());
      int sectionId = await db.insertSection(name, description);
      emit(SectionAdded(sectionId));
      await fetchSections(); // Refresh the list after adding a section
    } catch (e) {
      emit(SectionError('Failed to add section: ${e.toString()}'));
    }
  }

  // Fetch all sections
  Future<void> fetchSections() async {
    try {
      emit(SectionLoading());
      List<Map<String, dynamic>> sections = await db.getSections();
      emit(SectionLoaded(sections));
    } catch (e) {
      emit(SectionError('Failed to fetch sections: ${e.toString()}'));
    }
  }
}
