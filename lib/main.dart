import 'package:attendy/features/home/logic/section_cubit/section_cubit.dart';
import 'package:attendy/features/week/logic/week_cubit/week_cubit.dart';
import 'package:attendy/features/week/logic/week_students_cubit/week_students_cubit.dart';
import 'package:attendy/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants.dart';
import 'core/sqflite/attendy_sqflite.dart';
import 'core/utils/app_router.dart';
import 'features/student/logic/student_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>StudentCubit(AttendySqflite())
        ),
        BlocProvider(
          create: (context) => SectionCubit(AttendySqflite()),
        ),
        BlocProvider(
          create: (context) => WeekCubit(AttendySqflite()),
        ),
        BlocProvider(
          create: (context) => WeekStudentsCubit(AttendySqflite()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: MaterialColor(
              kPrimaryColor.value,
              const {
                50: Color(0xfff5f5f5),
                100: Color(0xffe7e7e7),
                200: Color(0xffbdbdbd),
                300: Color(0xff9e9e9e),
                400: Color(0xff757575),
                500: Color(0xff616161),
                600: Color(0xff454545),
                700: Color(0xff2c2c2c),
                800: Color(0xff1d1d1d),
                900: Color(0xff030303),
              },
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
      ),
    );
  }
}
