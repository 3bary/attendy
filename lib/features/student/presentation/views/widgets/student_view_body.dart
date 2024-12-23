import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/student_cubit.dart';

class StudentViewBody extends StatelessWidget {
  StudentViewBody({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Student Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _levelController,
                decoration: const InputDecoration(
                  labelText: 'Level',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the level';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final name = _nameController.text;
                          final level = _levelController.text;

                          // Use the Cubit to add the student
                          context.read<StudentCubit>().addStudent(name, level);
                          //clear the form
                          _nameController.clear();
                          _levelController.clear();
                        }
                      },
                      child: const Text('Add Student'),
                    ),
                  ),
                ],
              ),
              // BlocListener for handling state changes
              BlocListener<StudentCubit, StudentState>(
                listener: (context, state) {
                  if (state is StudentAddedSuccess) {
                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Student added successfully')),
                    );
                  } else if (state is StudentAddedFailure) {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                child: Container(), // Empty container since the logic is in the listener
              ),
            ],
          ),
        ),
      ),
    );
  }
}
