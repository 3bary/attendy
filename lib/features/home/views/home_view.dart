import 'package:flutter/material.dart';

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
