import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_app/cubit/task_cubit.dart';

import '../models/task.dart';
import 'add_edit_task.dart';
import 'popup_menu.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.task}) : super(key: key);

  final Task task;

  void _addNewTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const AddEditTask(),
        ),
      ),
    );
  }

  _editTask(BuildContext context) {
    print(task);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddEditTask(task: task),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: Row(
            children: [
              task.isFavorite == false
                  ? const Icon(Icons.star_outline)
                  : const Icon(Icons.star),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        decoration:
                            task.isDone! ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    Text(
                      DateFormat()
                          .add_yMMMd()
                          .add_Hms()
                          .format(DateTime.parse(task.createdAt!)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted!
                    ? null
                    : (value) {
                        context.read<TaskCubit>().completedTask(task);
                      }),
            PopupMenu(
              task: task,
              editCallback: () {
                // print("editcallback");
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: AddEditTask(task: task),
                    ),
                  ),
                );
                // print("why");
              },
              likeOrDislikeCallback: () {},
              cancelOrDeleteCallback: () {},
              restoreTaskCallback: () => {},
            ),
          ],
        ),
      ],
    );
  }
}
