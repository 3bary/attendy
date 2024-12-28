import 'package:attendy/features/home/logic/section_cubit/section_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_router.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    context.read<SectionCubit>().fetchSections();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SectionCubit, SectionState>(
      builder: (context, state) {
        if (state is SectionLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SectionLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: state.sections.length + 1, // Add an empty space at the end
            itemBuilder: (context, index) {
              if (index == state.sections.length) {
                return const SizedBox(height: 100); // Empty space at the end
              }
              final section = state.sections[index]; // Map<String, dynamic>
              return Card(
                child: ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      GoRouter.of(context).push(
                          AppRouter.kSectionDetailsView,
                          extra: {'sectionId': section.sectionId, 'sectionName': section.name});
                    },
                  ),
                  title: Text(section.name),
                  subtitle: Text(section.description),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.arrow_forward,
                    ),
                    onPressed: () {
                      GoRouter.of(context)
                          .push(AppRouter.kWeekView, extra: section.sectionId);
                    },
                  ),
                ),
              );
            },
          );
        } else if (state is SectionError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('No sections available.'));
        }
      },
    );
  }
}
