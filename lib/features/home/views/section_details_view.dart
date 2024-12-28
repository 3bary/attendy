import 'package:attendy/features/home/logic/section_cubit/section_cubit.dart';
import 'package:attendy/features/student/logic/student_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionDetailsView extends StatefulWidget {
  final int sectionId;
  final String sectionName;
  const SectionDetailsView({super.key, required this.sectionId, required this.sectionName});

  @override
  State<SectionDetailsView> createState() => _SectionDetailsViewState();
}

class _SectionDetailsViewState extends State<SectionDetailsView> {

  @override
  void initState() {
    context.read<StudentCubit>().fetchAllStudents();
    super.initState();
  }
  final TextEditingController _searchController = TextEditingController();
  List<int> selectedStudentIds = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Students to ${widget.sectionName}'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Students',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (query) {
                context.read<StudentCubit>().searchStudents(query);
              },
            ),
          ),
          // Students List
          Expanded(
            child: BlocBuilder<StudentCubit, StudentState>(
              builder: (context, state) {
                if (state is StudentLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is StudentLoaded) {
                  final students = state.students;
                  if (students.isEmpty) {
                    return const Center(
                      child: Text('No students found.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      final isSelected =
                      selectedStudentIds.contains(student.id);
                      return ListTile(
                        title: Text(student.name),
                        subtitle: Text('Level: ${student.level}'),
                        trailing: Checkbox(
                          value: isSelected,
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                selectedStudentIds.add(student.id);
                              } else {
                                selectedStudentIds.remove(student.id);
                              }
                            });
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('Failed to load students.'));
                }
              },
            ),
          ),

          // Assign Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (selectedStudentIds.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No students selected.'),
                    ),
                  );
                  return;
                }
                context.read<SectionCubit>().assignStudentsToSection(
                  widget.sectionId,
                  selectedStudentIds,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Students assigned successfully!'),
                  ),
                );

                Navigator.pop(context);
              },
              child: const Text('Assign Selected Students'),
            ),
          ),
        ],
      ),
    );
  }
}
