import 'task.dart';

class TaskPackage {
  final String categoryId;
  final String packageId; // e.g. "A"
  final List<Task> tasks;

  TaskPackage({
    required this.categoryId,
    required this.packageId,
    required this.tasks,
  });

  factory TaskPackage.fromJson(String categoryId, String packageId, Map<String, dynamic> json) {
    final tasksList = <Task>[];
    if (json['tasks'] != null) {
      final tasksJson = json['tasks'] as List;
      for (var taskJson in tasksJson) {
        if (taskJson is Map<String, dynamic>) {
          tasksList.add(Task.fromJson(taskJson));
        } else if (taskJson is String) {
          // Backward compatibility: if task is just a string, use it as title
          tasksList.add(Task(
            title: {'tr': taskJson, 'en': taskJson, 'de': taskJson},
            detail: {'tr': '', 'en': '', 'de': ''},
          ));
        }
      }
    }
    return TaskPackage(
      categoryId: categoryId,
      packageId: packageId,
      tasks: tasksList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'packageId': packageId,
      'tasks': tasks.map((t) => t.toJson()).toList(),
    };
  }
}
