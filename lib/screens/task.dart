import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomato/provider/task_provider.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksState = ref.watch(tasksProvider);
    final tasksNotifier = ref.read(tasksProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tasks',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 20),
                    onPressed: () => _showAddTaskDialog(context, ref),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Templates',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1,
                ),
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              height: 80, // Shorter height for templates
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                scrollDirection: Axis.horizontal,
                itemCount: tasksState.templates.length + 1,
                itemBuilder: (context, index) {
                  if (index == tasksState.templates.length) {
                    return _buildAddTemplateButton(context, ref);
                  }

                  final template = tasksState.templates[index];
                  return _buildTemplateCard(
                    context,
                    template,
                    () => tasksNotifier.addFromTemplate(template.id),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Today',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child:
                  tasksState.tasks.isEmpty
                      ? Center(
                        child: Text(
                          'No tasks',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      )
                      : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        itemCount: tasksState.tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasksState.tasks[index];
                          return _buildTaskItem(context, ref, task);
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateCard(
    BuildContext context,
    Task template,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(right: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade900, width: 1),
      ),
      color: Colors.black,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 120,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                template.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
              const Spacer(),
              Text(
                '${template.estimatedPomodoros}×',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddTemplateButton(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(right: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade900, width: 1),
      ),
      color: Colors.black,
      child: InkWell(
        onTap: () => _showAddTemplateDialog(context, ref),
        child: Container(
          width: 60,
          alignment: Alignment.center,
          child: Icon(Icons.add, color: Colors.grey.shade600, size: 20),
        ),
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, WidgetRef ref, Task task) {
    final tasksNotifier = ref.read(tasksProvider.notifier);
    final isActive = ref.watch(tasksProvider).activeTaskId == task.id;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade900, width: 1),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isActive ? FontWeight.normal : FontWeight.w300,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            color: task.isCompleted ? Colors.grey.shade600 : Colors.white,
          ),
        ),
        subtitle: Text(
          '${task.completedPomodoros}/${task.estimatedPomodoros}',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        leading: Checkbox(
          value: task.isCompleted,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          side: BorderSide(color: Colors.grey.shade600),
          onChanged: (checked) {
            if (checked == true) {
              tasksNotifier.completeTask(task.id);
            }
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.clear, size: 16, color: Colors.grey.shade600),
          onPressed: () => tasksNotifier.removeTask(task.id),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        onTap: () {
          if (!task.isCompleted) {
            tasksNotifier.setActiveTask(task.id);
          }
        },
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    int estimatedPomodoros = 1;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Colors.black,
                title: const Text(
                  'New Task',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                contentPadding: const EdgeInsets.all(20),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Task name',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey.shade800),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Pomodoros:',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.remove,
                            size: 16,
                            color: Colors.grey,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed:
                              estimatedPomodoros > 1
                                  ? () => setState(() => estimatedPomodoros--)
                                  : null,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '$estimatedPomodoros',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          icon: Icon(Icons.add, size: 16, color: Colors.grey),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () => setState(() => estimatedPomodoros++),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(foregroundColor: Colors.grey),
                    child: const Text('CANCEL'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (titleController.text.trim().isNotEmpty) {
                        final task = Task(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          title: titleController.text.trim(),
                          estimatedPomodoros: estimatedPomodoros,
                          createdAt: DateTime.now(),
                        );
                        ref.read(tasksProvider.notifier).addTask(task);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('SAVE'),
                  ),
                ],
              );
            },
          ),
    );
  }

  void _showAddTemplateDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    int estimatedPomodoros = 1;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Colors.black,
                title: const Text(
                  'New Template',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                contentPadding: const EdgeInsets.all(20),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Template name',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey.shade800),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Pomodoros:',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.remove,
                            size: 16,
                            color: Colors.grey,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed:
                              estimatedPomodoros > 1
                                  ? () => setState(() => estimatedPomodoros--)
                                  : null,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '$estimatedPomodoros',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          icon: Icon(Icons.add, size: 16, color: Colors.grey),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () => setState(() => estimatedPomodoros++),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(foregroundColor: Colors.grey),
                    child: const Text('CANCEL'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (titleController.text.trim().isNotEmpty) {
                        final template = Task.template(
                          'template-${DateTime.now().millisecondsSinceEpoch}',
                          titleController.text.trim(),
                          '', // No description in minimalist design
                          estimatedPomodoros,
                        );
                        ref.read(tasksProvider.notifier).addTemplate(template);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('SAVE'),
                  ),
                ],
              );
            },
          ),
    );
  }
}
