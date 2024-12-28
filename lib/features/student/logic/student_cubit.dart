import 'package:attendy/core/models/student.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/sqflite/attendy_sqflite.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  final AttendySqflite db;
  List<Student> allStudents = []; // Holds all students for search and other operations.

  StudentCubit(this.db) : super(StudentInitial());

  Future<void> addStudent(String name, String level) async {
    try {
      emit(StudentLoading());
      // Insert student into the database
      await db.insertStudent(name, level);

      emit(StudentAddedSuccess());
    } catch (e) {
      emit(StudentAddedFailure('Failed to add student: ${e.toString()}'));
    }
  }

  void searchStudents(String query) {
    if (query.isEmpty) {
      // Emit all students if the query is empty
      emit(StudentLoaded(allStudents));
    } else {
      final filteredStudents = allStudents.where((student) {
        return student.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(StudentLoaded(filteredStudents));
    }
  }

  Future<void> fetchAllStudents() async {
    try {
      emit(StudentLoading());
      final students = await db.getAllStudents();
      allStudents = students; // Populate the allStudents list
      emit(StudentLoaded(students));
    } catch (e) {
      emit(StudentSearchFailure('Failed to fetch students: ${e.toString()}'));
    }
  }
}
