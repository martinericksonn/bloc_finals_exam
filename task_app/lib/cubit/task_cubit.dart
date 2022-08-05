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
  int get pendingTasksLength => state.pendingTasks.length;
  int get completedTasksLength => state.completedTasks.length;
  int get removedTasksLength => state.pendingTasks.length;
  int get favoriteTasksLength => state.favoriteTasks.length;

  void _emitState() {
    emit(TaskState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        removedTasks: state.removedTasks,
        favoriteTasks: state.favoriteTasks));
  }

  void addEditTask(String title, String description, isEdit) {
    if (isEdit != null) {
    } else {
      Task task = Task(title: title, description: description);

      state.pendingTasks.add(task);
    }

    _emitState();
  }

  void markDoneTask(Task task) {
    int index =
        state.pendingTasks.indexWhere((element) => element.id == task.id);

    state.completedTasks.add(state.pendingTasks[index]);
    state.pendingTasks.remove(state.pendingTasks[index]);

    _emitState();
  }
}
