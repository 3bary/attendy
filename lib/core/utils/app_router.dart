import 'package:attendy/features/home/views/section_details_view.dart';
import 'package:attendy/features/student/presentation/views/student_view.dart';
import 'package:attendy/features/week/presentation/week_details_view.dart';
import 'package:attendy/features/week/presentation/week_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/views/home_view.dart';
import '../../features/spalsh/presentation/views/splash_view.dart';

abstract class AppRouter {
  // example uncomment and use

  static const kHomeView = '/homeView';
  static const kWeekView = '/weekView';
  static const kWeekDetailsView = '/weekDetailsView';
  static const kStudentView = '/studentView';
  static const kSectionDetailsView = '/sectionDetailsView';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: kWeekView,
        builder: (context, state) => WeekView(
          sectionId: state.extra! as int,
        ),
      ),
      GoRoute(
        path: kWeekDetailsView,
        builder: (context, state) =>  WeekDetailsView(
          sectionId: state.extra as int,
        ),
      ),
      GoRoute(
        path: kStudentView,
        builder: (context, state) => const StudentView(),
      ),
      GoRoute(
        path: kSectionDetailsView,
        builder: (context, state) {
          // Retrieve the extra parameter
          final extras = state.extra as Map<String, dynamic>?;

          final sectionId = extras!['sectionId'];
          final sectionName = extras['sectionName'];

          return SectionDetailsView(
            sectionId: sectionId,
            sectionName: sectionName,
          );
        },
      ),
    ],
  );
}
