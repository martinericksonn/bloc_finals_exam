import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/cubit/task_cubit.dart';

import '../test_data.dart';
import '../widgets/tasks_list.dart';

class PendingTasksScreen extends StatelessWidget {
  const PendingTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Chip(
              label: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  return Text(
                    '${state.pendingTasks.length} Pending | ${state.completedTasks.length} Completed',
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              return TasksList(tasksList: state.pendingTasks);
            },
          )
        ],
      ),
    );
  }
}
