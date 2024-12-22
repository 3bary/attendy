import 'package:attendy/core/sqflite/attendy_sqflite.dart';
import 'package:attendy/features/week/data/models/week.dart';
import 'package:attendy/features/week/logic/week_cubit/week_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeekCubit extends Cubit<WeekState> {
  final AttendySqflite db;
  List<Week> weeks = [];

  WeekCubit(this.db) : super(WeekInitialState());

  Future<void> addWeek(int sectionId, int weekNumber) async {
    try {
      emit(WeekLoadingState());
      int weekId = await db.insertWeek(sectionId, weekNumber);
      if (weekId != -1) {
        weeks.add(
            Week(weekId: weekId, sectionId: sectionId, weekNumber: weekNumber));
        emit(WeekLoadedState(weeks));
      } else {
        emit(WeekErrorState(
            'Week $weekNumber already exists for this section.'));
      }
    } catch (e) {
      emit(WeekErrorState('Failed to add week: ${e.toString()}'));
    }
  }

  Future<void> fetchWeeks(int sectionId) async {
    try {
      emit(WeekLoadingState());
      weeks = await db.getWeeks(sectionId);
      emit(WeekLoadedState(weeks));
    } catch (e) {
      emit(WeekErrorState('Failed to fetch weeks: ${e.toString()}'));
    }
  }
}
