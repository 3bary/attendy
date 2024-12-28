import 'package:attendy/core/sqflite/attendy_sqflite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:attendy/core/models/student.dart';

part 'week_students_status.dart';

enum WeekStudentStatus { Absent, Present }

class WeekStudentsCubit extends Cubit<WeekStudentsState> {
  final AttendySqflite db;
  List<Student> students = [];
  WeekStudentsCubit(this.db) : super(WeekInitial());

  Future<void> fetchWeekStudents(int sectionId,int weekId) async {
    try {
      emit(WeekLoading());
      final rows = await db.getSectionStudentsWithStatus(sectionId, weekId);
      students = rows.map((e) => Student.fromMap(e)).toList();
      //print students
      for (var student in students) {
        print('Student ID: ${student.id},Week ID: $weekId, Name: ${student.name}, Level: ${student.level} Status: ${student.status}');
      }
      emit(WeekStudentsLoaded(students));
    } catch (e) {
      emit(WeekStudentsError('Failed to fetch students: ${e.toString()}'));
    }
  }

  Future<void> updateStudentStatus(
      int weekId, int studentId, WeekStudentStatus status) async {
    try {
      final statusString =
          status.toString().split('.').last; // Convert to string
      await db.updateAttendanceStatus(weekId, studentId, statusString);
    } catch (e) {
      emit(WeekStudentsError('Failed to update attendance: ${e.toString()}'));
    }
  }
}
