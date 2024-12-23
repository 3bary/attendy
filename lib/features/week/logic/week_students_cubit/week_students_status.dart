part of 'week_students_cubit.dart';


abstract class WeekStudentsState {}

class WeekInitial extends WeekStudentsState {}

class WeekLoading extends WeekStudentsState {}

class WeekStudentsLoaded extends WeekStudentsState {
  final int weekId;
  final List<Student> students;

  WeekStudentsLoaded(this.weekId, this.students);
}

class WeekStudentsError extends WeekStudentsState {
  final String message;

  WeekStudentsError(this.message);
}
