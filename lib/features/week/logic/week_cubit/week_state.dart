import 'package:attendy/features/week/data/models/week.dart';

abstract class WeekState {}

class WeekInitialState extends WeekState {}

class WeekLoadingState extends WeekState {}

class WeekLoadedState extends WeekState {
  final List<Week> weeks;

  WeekLoadedState(this.weeks);
}

class WeekErrorState extends WeekState {
  final String message;

  WeekErrorState(this.message);
}

class WeekAddedState extends WeekState {
  final String successMessage;

  WeekAddedState(this.successMessage);
}
