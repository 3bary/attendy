import 'package:flutter/material.dart';

import 'widgets/student_view_body.dart';

class StudentView extends StatelessWidget {
  const StudentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Students'),
      ),
      body: StudentViewBody(),
    );
  }
}
