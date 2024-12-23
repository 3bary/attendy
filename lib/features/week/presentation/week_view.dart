import 'package:attendy/features/week/presentation/wedgits/add_week_button.dart';
import 'package:attendy/features/week/presentation/wedgits/week_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/sqflite/attendy_sqflite.dart';
import '../logic/week_cubit/week_cubit.dart';

class WeekView extends StatelessWidget {
  final int sectionId;

  const WeekView({super.key, required this.sectionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weeks'),
        elevation: 0.7,
      ),
      body: WeekViewBody(
        sectionId: sectionId,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            context: context,
            builder: (context) => AddWeekBottomSheet(
              sectionId: sectionId,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
