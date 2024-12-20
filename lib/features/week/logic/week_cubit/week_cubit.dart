// import 'package:attendy/features/week/logic/week_cubit/week_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/sqflite/attendy_sqflite.dart';
//
//
// class WeekCubit extends Cubit<WeekState> {
//   final AttendySqflite databaseHelper;
//
//   WeekCubit(this.databaseHelper) : super(WeekInitialState());
//
//   // Load weeks for a specific section
//   Future<void> loadWeeks(int sectionId) async {
//     emit(WeekLoadingState());
//     try {
//       final weeks = await databaseHelper.getWeeks(sectionId);
//       emit(WeekLoadedState(weeks));
//     } catch (e) {
//       emit(WeekErrorState('Failed to load weeks: $e'));
//     }
//   }
//
//   // Add a new week for a section
//   Future<void> addWeek(int sectionId, int weekNumber) async {
//     emit(WeekLoadingState());
//     try {
//       final result = await databaseHelper.insertWeek(sectionId, weekNumber);
//       if (result != -1) {
//         emit(WeekAddedState('Week $weekNumber added successfully!'));
//         await loadWeeks(sectionId); // Reload weeks after adding
//       } else {
//         emit(WeekErrorState('Week $weekNumber already exists in this section.'));
//       }
//     } catch (e) {
//       emit(WeekErrorState('Failed to add week: $e'));
//     }
//   }
// }
//
//

import 'package:attendy/core/sqflite/attendy_sqflite.dart';
import 'package:attendy/features/week/logic/week_cubit/week_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeekCubit extends Cubit<WeekState> {
  final AttendySqflite db;

  WeekCubit(this.db) : super(WeekInitialState());

  // Add a new week
  Future<void> addWeek(int sectionId, int weekNumber) async {
    try {
      emit(WeekLoadingState());
      int result = await db.insertWeek(sectionId, weekNumber);
      if (result != -1) {
        emit(WeekAddedState('Week $weekNumber added successfully!'));
        await fetchWeeks(sectionId); // Refresh the list after adding a week
      } else {
        emit(WeekErrorState(
            'Week $weekNumber already exists for this section.'));
      }
    } catch (e) {
      emit(WeekErrorState('Failed to add week: ${e.toString()}'));
    }
  }

  // Fetch all weeks for a specific section
  Future<void> fetchWeeks(int sectionId) async {
    try {
      emit(WeekLoadingState());
      List<Map<String, dynamic>> weeks = await db.getWeeks(sectionId);
      emit(WeekLoadedState(weeks));
    } catch (e) {
      emit(WeekErrorState('Failed to fetch weeks: ${e.toString()}'));
    }
  }
}
