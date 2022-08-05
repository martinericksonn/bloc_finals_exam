import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/cubit/task_cubit.dart';
import 'package:task_app/cubit/theme_cubit.dart';

import '../screens/recycle_bin_screen.dart';
import '../screens/tabs_screen.dart';
import '../test_data.dart';

class TasksDrawer extends StatelessWidget {
  const TasksDrawer({Key? key}) : super(key: key);

  _switchToDarkTheme(BuildContext context, bool isDarkTheme) {
    if (isDarkTheme) {
      context.read<ThemeCubit>().switchLight();
    } else {
      context.read<ThemeCubit>().switchDark();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              child: Text(
                'Task Drawer',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.folder_special),
              title: const Text('My Tasks'),
              trailing: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  return Text(
                    '${state.pendingTasks.length} | ${state.completedTasks.length}',
                  );
                },
              ),
              onTap: () => Navigator.pushReplacementNamed(
                context,
                TabsScreen.path,
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Recycle Bin'),
              trailing: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  return Text('${state.removedTasks.length}');
                },
              ),
              onTap: () => Navigator.pushReplacementNamed(
                context,
                RecycleBinScreen.path,
              ),
            ),
            const Divider(),
            const Expanded(child: SizedBox()),
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return ListTile(
                  leading: Switch(
                    value: state.switchValue,
                    onChanged: (newValue) =>
                        _switchToDarkTheme(context, newValue),
                  ),
                  title: state.switchValue
                      ? const Text('Switch to Light Mode')
                      : const Text('Switch to Dark Mode'),
                  onTap: () => _switchToDarkTheme(context, !state.switchValue),
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
