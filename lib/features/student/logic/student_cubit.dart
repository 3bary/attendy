import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/sqflite/attendy_sqflite.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  final AttendySqflite db;

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
}
