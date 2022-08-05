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

  void completedTask(Task task) {
    if (task.isDone == true) {
      int index =
          state.completedTasks.indexWhere((element) => element.id == task.id);

      var undoneTask = state.completedTasks[index].copyWith(isDone: false);
      state.pendingTasks.add(undoneTask);
      state.completedTasks.remove(state.completedTasks[index]);

      _emitState();

      return;
    }

    int index =
        state.pendingTasks.indexWhere((element) => element.id == task.id);

    var doneTask = state.pendingTasks[index].copyWith(isDone: true);
    print(doneTask);
    state.completedTasks.add(doneTask);
    state.pendingTasks.remove(state.pendingTasks[index]);

    _emitState();
  }
}
