part of 'student_cubit.dart';

abstract class StudentState {}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentAddedSuccess extends StudentState {}

class StudentAddedFailure extends StudentState {
  final String message;

  StudentAddedFailure(this.message);
}
