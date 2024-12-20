import 'package:attendy/features/home/logic/section_cubit/section_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSectionBottomSheet extends StatelessWidget {
  AddSectionBottomSheet({super.key});
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Section Name'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final description = descriptionController.text.trim();

              if (name.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Section name cannot be empty')),
                );
                return;
              }

              // Add the section using the Cubit
              context.read<SectionCubit>().addSection(name, description);

              // Close the bottom sheet
              Navigator.pop(context);
            },
            child: const Text('Add Section'),
          ),
        ],
      ),
    );
  }
}
