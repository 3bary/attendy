import 'package:attendy/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../logic/week_cubit/week_cubit.dart';
import '../../logic/week_cubit/week_state.dart';

class WeekViewBody extends StatefulWidget {
  final int sectionId;

  // ID of the section to fetch weeks for

  const WeekViewBody({
    super.key,
    required this.sectionId,
  });

  @override
  State<WeekViewBody> createState() => _WeekViewBodyState();
}

class _WeekViewBodyState extends State<WeekViewBody> {
  @override
  void initState() {
    context
        .read<WeekCubit>()
        .fetchWeeks(widget.sectionId); // Fetch weeks for the section
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeekCubit, WeekState>(
      builder: (context, state) {
        if (state is WeekLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WeekLoadedState) {
          return ListView.builder(
            itemCount: state.weeks.length,
            itemBuilder: (context, index) {
              final week = state.weeks[index]; // Map<String, dynamic>
              return Card(
                child: ListTile(
                  title: Text('Week ${week.weekNumber}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      // Navigate to week details view
                      GoRouter.of(context).push(AppRouter.kWeekDetailsView, extra: widget.sectionId);
                    },
                  ),
                ),
              );
            },
          );
        } else if (state is WeekErrorState) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('No weeks available.'));
        }
      },
    );
  }
}
