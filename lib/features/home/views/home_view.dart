import 'package:attendy/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/add_section_bottom_sheet.dart';
import 'widgets/home_view_body.dart';



class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Attendy'),
        elevation: 0.7,
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.person_add),
            label: const Text('Add Students'),
            onPressed: () {
              GoRouter.of(context).push(
                  AppRouter.kStudentView);
            },
          )
        ],
      ),
      body: const HomeViewBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)
              ),
              context: context,
              builder: (context) => AddSectionBottomSheet()
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
