// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:task_app/models/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> with HydratedMixin {
  TaskCubit()
      : super(TaskState(
          pendingTasks: [],
          completedTasks: [],
          removedTasks: [],
          favoriteTasks: [],
        ));

  void _emitState() {
    emit(TaskState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        removedTasks: state.removedTasks,
        favoriteTasks: state.favoriteTasks));
  }

  void addEditTask(String title, String description, task) {
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

    for (List<Task> categories in taskCategories) {
      var index = categories.indexWhere((element) => element.id == task.id);
      if (index == -1) continue;

      categories[index] = categories[index]
          .copyWith(description: description)
          .copyWith(title: title);

      _emitState();
    }
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
    List<List<Task>> taskCategories = [
      state.pendingTasks,
      state.completedTasks,
      state.removedTasks
    ];

    for (List<Task> categories in taskCategories) {
      var index = categories.indexWhere((element) => element.id == task.id);
      if (index == -1) continue;

      var currentTask =
          categories[index].copyWith(isFavorite: !task.isFavorite!);
      categories[index] = currentTask;

      currentTask.isFavorite!
          ? state.favoriteTasks.add(currentTask)
          : state.favoriteTasks.remove(task);

      _emitState();
    }
  }

  void deleteTask(Task task) {
    List<List<Task>> taskCategories = [
      state.pendingTasks,
      state.completedTasks,
      state.favoriteTasks
    ];

    if (task.isDeleted!) {
      state.removedTasks.remove(task);
      _emitState();
      return;
    }

    for (List<Task> categories in taskCategories) {
      var index = categories.indexWhere((element) => element.id == task.id);
      if (index == -1) {
        continue;
      }
      var deletedTask = categories[index].copyWith(isDeleted: !task.isDeleted!);
      categories.remove(task);

      if (!state.removedTasks.contains(deletedTask)) {
        state.removedTasks.add(deletedTask);
      }
    }

    _emitState();
    return;
  }

  void restoreTask(Task task) {
    state.removedTasks.remove(task);
    task = task.copyWith(isDeleted: false);

    if (task.isDone!) {
      state.completedTasks.add(task);
    } else {
      state.pendingTasks.add(task);
    }

    if (task.isFavorite!) {
      state.favoriteTasks.add(task);
    }

    _emitState();
  }

  void deleteALl() {
    state.removedTasks.clear();

    _emitState();
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}
