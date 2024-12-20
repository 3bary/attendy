
import 'package:go_router/go_router.dart';

import '../../features/home/views/home_view.dart';
import '../../features/spalsh/presentation/views/splash_view.dart';

abstract class AppRouter {
  // example uncomment and use

   static const kHomeView = '/homeView';
  // static const kBookDetailsView = '/bookDetailsView';
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
     ],
  );
}
