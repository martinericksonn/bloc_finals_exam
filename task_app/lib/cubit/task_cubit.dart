import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_app/models/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit()
      : super(TaskState(
          pendingTasks: [],
          completedTasks: [],
          removedTasks: [],
          favoriteTasks: [],
        ));

  void addEditTask(String title, String description, isEdit) {
    if (isEdit != null) {
    } else {
      Task task = Task(title: title, description: description);

      state.pendingTasks.add(task);
    }

    emit(TaskState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        removedTasks: state.removedTasks,
        favoriteTasks: state.favoriteTasks));
  }

  int get pendingTasksLength => state.pendingTasks.length;
  int get completedTasksLength => state.completedTasks.length;
  int get removedTasksLength => state.pendingTasks.length;
  int get favoriteTasksLength => state.favoriteTasks.length;
}
