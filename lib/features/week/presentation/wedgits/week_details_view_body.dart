
import 'package:attendy/features/week/logic/week_students_cubit/week_students_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeekDetailsViewBody extends StatefulWidget {
  const WeekDetailsViewBody({super.key, required this.sectionId});
  final int sectionId;

  @override
  State<WeekDetailsViewBody> createState() => _WeekDetailsViewBodyState();
}

class _WeekDetailsViewBodyState extends State<WeekDetailsViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<WeekStudentsCubit>().fetchSectionStudents(widget.sectionId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeekStudentsCubit, WeekStudentsState>(
      builder: (context, state) {
        if (state is WeekLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WeekStudentsLoaded) {
          return ListView.builder(
            itemCount: state.students.length,
            itemBuilder: (context, index) {
              final student = state.students[index];
              WeekStudentStatus weekStudentStatus =  WeekStudentStatus.Absent;
              return ListTile(
                title: Text(student.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<WeekStudentStatus>(
                      value: weekStudentStatus,
                      groupValue: weekStudentStatus,
                      onChanged: (value) {
                        print(value);
                        setState(() {

                          weekStudentStatus = WeekStudentStatus.Absent;
                        });
                        context.read<WeekStudentsCubit>().updateStudentStatus(
                          state.weekId,
                          student.id,
                          value!,
                        );
                      },
                    ),
                    Radio<WeekStudentStatus>(
                      value: WeekStudentStatus.Present,
                      groupValue: weekStudentStatus,
                      onChanged: (value) {
                        setState(() {
                          weekStudentStatus = value!;
                        });
                        context.read<WeekStudentsCubit>().updateStudentStatus(
                          state.weekId,
                          student.id,
                          value!,
                        );
                      },
                    ),
                    Radio<WeekStudentStatus>(
                      value: WeekStudentStatus.Late,
                      groupValue: weekStudentStatus,
                      onChanged: (value) {
                        setState(() {
                          weekStudentStatus = value!;
                        });
                        context.read<WeekStudentsCubit>().updateStudentStatus(
                          state.weekId,
                          student.id,
                          value!,
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('No Students available.'));
        }
      },
    );
  }
}
