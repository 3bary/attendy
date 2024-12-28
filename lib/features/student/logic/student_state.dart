part of 'student_cubit.dart';

abstract class StudentState {}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentAddedSuccess extends StudentState {}

class StudentAddedFailure extends StudentState {
  final String message;

  StudentAddedFailure(this.message);
}
class StudentLoaded extends StudentState {
  final List<Student> students;

  StudentLoaded(this.students);
}
class StudentSearchFailure extends StudentState {
  final String message;

  StudentSearchFailure(this.message);
}