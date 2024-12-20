abstract class WeekState {}

class WeekInitialState extends WeekState {}

class WeekLoadingState extends WeekState {}

class WeekLoadedState extends WeekState {
  final List<Map<String, dynamic>> weeks;
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
