
import 'package:attendy/features/week/presentation/week_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/views/home_view.dart';
import '../../features/spalsh/presentation/views/splash_view.dart';

abstract class AppRouter {
  // example uncomment and use

   static const kHomeView = '/homeView';
   static const kWeekView = '/weekView';
  // static const kSearchView = '/searchView';
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
         builder: (context, state) =>  WeekView(sectionId: state.extra! as int,),
       ),
     ],
  );
}
