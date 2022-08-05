part of 'task_cubit.dart';

class TaskState {
  List<Task> pendingTasks = [];
  List<Task> completedTasks = [];
  List<Task> removedTasks = [];
  List<Task> favoriteTasks = [];

  TaskState({
    required this.pendingTasks,
    required this.completedTasks,
    required this.removedTasks,
    required this.favoriteTasks,
  });

  @override
  List<Object> get props => [];
}
