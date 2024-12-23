import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/week_students_cubit/week_students_cubit.dart';

class WeekDetailsViewBody extends StatelessWidget {
  const WeekDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<WeekStudentsCubit, WeekStudentsState>(
      builder: (context, state) {
        if (state is WeekStudentsLoaded) {
          return ListView.builder(
            itemCount: state.students.length,
            itemBuilder: (context, index) {
              final student = state.students[index];
              return ListTile(
                title: Text(student.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<WeekStudentStatus>(
                      value: WeekStudentStatus.Absent,
                      groupValue: WeekStudentStatus.values
                          .firstWhere((e) => e.toString().split('.').last == student.status),
                      onChanged: (value) {
                        context.read<WeekStudentsCubit>().updateStudentStatus(
                          state.weekId,
                          student.id,
                          value!,
                        );
                      },
                    ),
                    Radio<WeekStudentStatus>(
                      value: WeekStudentStatus.Present,
                      groupValue: WeekStudentStatus.values
                          .firstWhere((e) => e.toString().split('.').last == student.status),
                      onChanged: (value) {
                        context.read<WeekStudentsCubit>().updateStudentStatus(
                          state.weekId,
                          student.id,
                          value!,
                        );
                      },
                    ),
                    Radio<WeekStudentStatus>(
                      value: WeekStudentStatus.Late,
                      groupValue: WeekStudentStatus.values
                          .firstWhere((e) => e.toString().split('.').last == student.status),
                      onChanged: (value) {
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
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
