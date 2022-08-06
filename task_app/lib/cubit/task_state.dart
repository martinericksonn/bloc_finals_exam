// ignore_for_file: public_member_api_docs, sort_constructors_first

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pendingTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'completedTasks': completedTasks.map((x) => x.toMap()).toList(),
      'removedTasks': removedTasks.map((x) => x.toMap()).toList(),
      'favoriteTasks': favoriteTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
      pendingTasks: List<Task>.from(
        (map['pendingTasks'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
      completedTasks: List<Task>.from(
        (map['completedTasks'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
      removedTasks: List<Task>.from(
        (map['removedTasks'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
      favoriteTasks: List<Task>.from(
        (map['favoriteTasks'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskState.fromJson(String source) =>
      TaskState.fromMap(json.decode(source) as Map<String, dynamic>);
}
