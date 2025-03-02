import 'package:attendy/features/week/presentation/wedgits/week_details_view_body.dart';
import 'package:flutter/material.dart';

class WeekDetailsView extends StatelessWidget {
  const WeekDetailsView({super.key, required this.weekId, required this.sectionID});
  final int weekId;
  final int sectionID;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Week Details'),
      ),
      body:  WeekDetailsViewBody(weekId: weekId, sectionId: sectionID,),
    );
  }
}
