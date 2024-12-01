
import 'package:attendy/features/splash/presentation/views/splash_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  // example uncomment and use

  // static const kHomeView = '/homeView';
  // static const kBookDetailsView = '/bookDetailsView';
  // static const kSearchView = '/searchView';
   static final router = GoRouter(
     routes: [
       GoRoute(
         path: '/',
         builder: (context, state) => const SplashView(),
       ),
  //     GoRoute(
  //       path: kHomeView,
  //       builder: (context, state) => const HomeView(),
  //     ),
     ],
  );
}
