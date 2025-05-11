import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_provider.g.dart';
part 'task_provider.freezed.dart';

@freezed
abstract class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    String? description,
    @Default(1) int estimatedPomodoros,
    @Default(0) int completedPomodoros,
    DateTime? createdAt,
    DateTime? completedAt,
    @Default(false) bool isCompleted,
    @Default(false) bool isTemplate,
  }) = _Task;

  factory Task.template(
    String id,
    String title,
    String description,
    int estimatedPomodoros,
  ) {
    return Task(
      id: id,
      title: title,
      description: description,
      estimatedPomodoros: estimatedPomodoros,
      isTemplate: true,
      createdAt: DateTime.now(),
    );
  }

  factory Task.fromTemplate(Task template) {
    return Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: template.title,
      description: template.description,
      estimatedPomodoros: template.estimatedPomodoros,
      createdAt: DateTime.now(),
    );
  }
}

@freezed
abstract class TasksState with _$TasksState {
  const TasksState._();

  const factory TasksState({
    required List<Task> tasks,
    required List<Task> templates,
    String? activeTaskId,
  }) = _TasksState;

  factory TasksState.initial() {
    return TasksState(
      tasks: [],
      templates: [
        Task.template(
          'template-1',
          'Deep Work Session',
          'Focus on a single important task without distractions',
          4,
        ),
        Task.template(
          'template-2',
          'Email Processing',
          'Process emails and respond to urgent ones',
          2,
        ),
        Task.template(
          'template-3',
          'Learn Something New',
          'Dedicated learning time',
          3,
        ),
      ],
    );
  }

  Task? get activeTask =>
      activeTaskId != null
          ? tasks.firstWhere(
            (t) => t.id == activeTaskId,
            orElse: () => Task(id: '', title: ''),
          )
          : null;

  List<Task> get incompleteTasks => tasks.where((t) => !t.isCompleted).toList();

  int get totalEstimatedMinutes {
    return incompleteTasks.fold(
      0,
      (sum, task) =>
          sum +
          task.estimatedPomodoros * 25 +
          (task.estimatedPomodoros - 1) * 5,
    );
  }
}

@riverpod
class Tasks extends _$Tasks {
  @override
  TasksState build() {
    return TasksState.initial();
  }

  void addTask(Task task) {
    state = state.copyWith(tasks: [...state.tasks, task]);
  }

  void addFromTemplate(String templateId) {
    final template = state.templates.firstWhere(
      (t) => t.id == templateId,
      orElse: () => Task(id: '', title: ''),
    );

    if (template.id.isNotEmpty) {
      final newTask = Task.fromTemplate(template);
      addTask(newTask);
    }
  }

  void setActiveTask(String taskId) {
    state = state.copyWith(activeTaskId: taskId);
  }

  void completeTask(String taskId) {
    final updatedTasks =
        state.tasks.map((task) {
          if (task.id == taskId) {
            return task.copyWith(
              isCompleted: true,
              completedAt: DateTime.now(),
            );
          }
          return task;
        }).toList();

    state = state.copyWith(tasks: updatedTasks);

    // If this was the active task, clear it
    if (state.activeTaskId == taskId) {
      state = state.copyWith(activeTaskId: null);
    }
  }

  void incrementTaskPomodoros(String taskId) {
    final updatedTasks =
        state.tasks.map((task) {
          if (task.id == taskId) {
            final newCount = task.completedPomodoros + 1;

            // If all estimated pomodoros are completed, mark task as done
            final isCompleted = newCount >= task.estimatedPomodoros;

            return task.copyWith(
              completedPomodoros: newCount,
              isCompleted: isCompleted,
              completedAt: isCompleted ? DateTime.now() : null,
            );
          }
          return task;
        }).toList();

    state = state.copyWith(tasks: updatedTasks);
  }

  void addTemplate(Task template) {
    if (!template.isTemplate) {
      template = template.copyWith(isTemplate: true);
    }

    state = state.copyWith(templates: [...state.templates, template]);
  }

  void removeTask(String taskId) {
    state = state.copyWith(
      tasks: state.tasks.where((t) => t.id != taskId).toList(),
    );

    // If this was the active task, clear it
    if (state.activeTaskId == taskId) {
      state = state.copyWith(activeTaskId: null);
    }
  }

  // Clear all tasks but keep templates
  void clearTasks() {
    state = state.copyWith(tasks: [], activeTaskId: null);
  }
}
