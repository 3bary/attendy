part of 'week_students_cubit.dart';

abstract class WeekStudentsState {}

class WeekInitial extends WeekStudentsState {}

class WeekLoading extends WeekStudentsState {}

class WeekStudentsLoaded extends WeekStudentsState {
  final List<Student> students;

  WeekStudentsLoaded(this.students);
}

class WeekStudentsError extends WeekStudentsState {
  final String message;

  WeekStudentsError(this.message);
}
