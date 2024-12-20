import 'package:attendy/features/week/logic/week_cubit/week_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddWeekBottomSheet extends StatelessWidget {
  AddWeekBottomSheet({super.key, required this.sectionId});

  final int sectionId; // The ID of the section
  final weekNumberController = TextEditingController();

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
            controller: weekNumberController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Week Number'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final weekNumberText = weekNumberController.text.trim();

              if (weekNumberText.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Week number cannot be empty')),
                );
                return;
              }

              final weekNumber = int.tryParse(weekNumberText);
              if (weekNumber == null || weekNumber <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter a valid week number')),
                );
                return;
              }

              // Add the week using the Cubit
              context.read<WeekCubit>().addWeek(sectionId, weekNumber);


              // Close the bottom sheet
              Navigator.pop(context);
            },
            child: const Text('Add Week'),
          ),
        ],
      ),
    );
  }
}


//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../logic/week_cubit/week_cubit.dart';
// import '../../logic/week_cubit/week_state.dart';
//
// class AddWeekBottomSheet extends StatelessWidget {
//   AddWeekBottomSheet({super.key, required this.sectionId});
//
//   final int sectionId; // The ID of the section
//   final weekNumberController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<WeekCubit, WeekState>(
//       listener: (context, state) {
//         if (state is WeekLoadingState) {
//           // Show a loading indicator (optional)
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Adding week...')),
//           );
//         } else if (state is WeekAddedState) {
//           // Show success message
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.successMessage)),
//           );
//           Navigator.pop(context); // Close the bottom sheet after adding the week
//         } else if (state is WeekErrorState) {
//           // Show error message
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.message)),
//           );
//         }
//       },
//       child: Padding(
//         padding: EdgeInsets.only(
//           left: 16,
//           right: 16,
//           top: 16,
//           bottom: MediaQuery.of(context).viewInsets.bottom + 16,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: weekNumberController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Week Number'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 final weekNumberText = weekNumberController.text.trim();
//
//                 if (weekNumberText.isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Week number cannot be empty')),
//                   );
//                   return;
//                 }
//
//                 final weekNumber = int.tryParse(weekNumberText);
//                 if (weekNumber == null || weekNumber <= 0) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Enter a valid week number')),
//                   );
//                   return;
//                 }
//
//                 // Add the week using the Cubit
//                 context.read<WeekCubit>().addWeek(sectionId, weekNumber);
//               },
//               child: const Text('Add Week'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
