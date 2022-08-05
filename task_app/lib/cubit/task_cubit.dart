import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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

  void addEditTask(String title, String description, task) {
    print("zzz");
    List<List<Task>> taskCategories = [
      state.pendingTasks,
      state.completedTasks,
      state.favoriteTasks
    ];
    if (task == null) {
      Task task = Task(title: title, description: description);
      state.pendingTasks.add(task);

      _emitState();
      return;
    }
    print("hellooooo");
    for (List<Task> categories in taskCategories) {
      var index = categories.indexWhere((element) => element.id == task.id);
      if (index != -1) {
        print(categories[index]);
        print(categories);
      }
    }
    // if (state.completedTasks. !=
    //     -1) {}

    // if (state.favoriteTasks.indexWhere((element) => element.id == task.id) !=
    //     -1) {}

    // if (state.pendingTasks.indexWhere((element) => element.id == task.id) !=
    //     -1) {}
  }

  void completedTask(
    Task task,
  ) {
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
    state.completedTasks.add(doneTask);
    state.pendingTasks.remove(state.pendingTasks[index]);

    _emitState();
  }

  void favoriteTask(Task task) {
    print("object");
    List<List<Task>> taskCategories = [
      state.pendingTasks,
      state.completedTasks,
    ];

    for (List<Task> categories in taskCategories) {
      var index = categories.indexWhere((element) => element.id == task.id);

      if (index != -1) {
        var currentTask =
            categories[index].copyWith(isFavorite: !task.isFavorite!);
        categories[index] = currentTask;

        if (currentTask.isFavorite!) {
          state.favoriteTasks.add(currentTask);
        } else {
          state.favoriteTasks.remove(task);
        }

        _emitState();
        return;
      }
    }

    // if (task.isFavorite == true) {
    //   task.copyWith(isFavorite: false);
    //   state.favoriteTasks.remove(task);
    //   _emitState();
    //   return;
    // }

    // task.copyWith(isFavorite: true);
    // state.favoriteTasks.add(task);
  }
}
