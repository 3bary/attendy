import 'package:attendy/core/models/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/week_students_cubit/week_students_cubit.dart';

class WeekDetailsViewBody extends StatefulWidget {
  const WeekDetailsViewBody({super.key, required this.weekId, required this.sectionId});
  final int weekId;
  final int sectionId;
  @override
  State<WeekDetailsViewBody> createState() => _WeekDetailsViewBodyState();
}

class _WeekDetailsViewBodyState extends State<WeekDetailsViewBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<WeekStudentsCubit>().fetchWeekStudents(widget.sectionId,widget.weekId);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeekStudentsCubit, WeekStudentsState>(
      builder: (context, state) {
        if (state is WeekStudentsLoaded) {
          return ListView.builder(
            itemCount: state.students.length,
            itemBuilder: (context, index) {
              final student = state.students[index];
              return ListTile(
                  title: Text(student.name),
                  trailing: CustomSwitch(
                    student: student,
                    studentId: student.id,
                    weekId: widget.weekId,
                  ));
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    super.key,
    required this.student,
    required this.studentId,
    required this.weekId,
  });
  final int studentId;
  final int weekId;
  final Student student;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool isPresent;
  @override
  initState() {
    super.initState();
    if(widget.student.status == 'Absent'){
      isPresent = false;
    }else{
      isPresent = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isPresent,
      onChanged: (value) {
        if (isPresent) {
          context.read<WeekStudentsCubit>().updateStudentStatus(
                widget.weekId,
                widget.studentId,
                WeekStudentStatus.Absent,
              );
        } else {
          context.read<WeekStudentsCubit>().updateStudentStatus(
              widget.weekId,
              widget.student.id,WeekStudentStatus.Present);
        }
        setState(() {
          isPresent = !isPresent;
        });

      },
    );
  }
}
