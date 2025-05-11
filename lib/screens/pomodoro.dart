import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomato/main.dart';
import 'package:tomato/provider/pomodoro.dart';
import 'package:tomato/provider/task_provider.dart';
import 'package:tomato/screens/fullscreen.dart';

class PomodoroScreen extends ConsumerStatefulWidget {
  const PomodoroScreen({super.key});

  @override
  ConsumerState<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends ConsumerState<PomodoroScreen>
    with TickerProviderStateMixin {
  final TextEditingController _taskController = TextEditingController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: ref.read(pomodoroProvider).currentDuration),
    );

    // Initial animation setup
    _updateAnimationController();
  }

  @override
  void dispose() {
    _taskController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _updateAnimationController() {
    final state = ref.read(pomodoroProvider);
    if (_animationController.isAnimating) {
      _animationController.stop();
    }
    _animationController.duration = Duration(seconds: state.currentDuration);
    if (state.isRunning) {
      _animationController.reverse(
        from: state.secondsRemaining / state.currentDuration,
      );
    } else {
      _animationController.value =
          1 - (state.secondsRemaining / state.currentDuration);
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  Color _getModeColor(TimerMode mode) {
    switch (mode) {
      case TimerMode.work:
        return Colors.white;
      case TimerMode.shortBreak:
        return Colors.grey.shade300;
      case TimerMode.longBreak:
        return Colors.grey.shade400;
    }
  }

  String _getModeText(TimerMode mode) {
    switch (mode) {
      case TimerMode.work:
        return "Focus";
      case TimerMode.shortBreak:
        return "Break";
      case TimerMode.longBreak:
        return "Rest";
    }
  }

  void _selectTaskFromList() {
    final tasksState = ref.read(tasksProvider);

    if (tasksState.incompleteTasks.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No tasks available. Add tasks in the Tasks tab."),
          // backgroundColor: Colors.black,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Color(0xFF121212),
            title: const Text("Select Task", style: TextStyle(fontSize: 16)),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: tasksState.incompleteTasks.length,
                itemBuilder: (context, index) {
                  final task = tasksState.incompleteTasks[index];
                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text(
                      '${task.completedPomodoros}/${task.estimatedPomodoros}',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    onTap: () {
                      ref.read(tasksProvider.notifier).setActiveTask(task.id);
                      ref
                          .read(pomodoroProvider.notifier)
                          .updateTask(task.title);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "CANCEL",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
    );
  }

  void _enterFullScreenMode() {
    ref.read(fullscreenModeProvider.notifier).state = true;
  }

  void _exitFullScreenMode() {
    ref.read(fullscreenModeProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pomodoroProvider);
    final notifier = ref.read(pomodoroProvider.notifier);
    final isFullScreenMode = ref.watch(fullscreenModeProvider);

    // Update animation controller when state changes
    ref.listen(pomodoroProvider, (previous, next) {
      if (previous?.mode != next.mode ||
          previous?.currentDuration != next.currentDuration ||
          (previous?.isRunning != next.isRunning)) {
        _updateAnimationController();

        // Auto-enter fullscreen mode when timer starts
        if (previous != null && !previous.isRunning && next.isRunning) {
          _enterFullScreenMode();
        }
      }
    });

    // If in fullscreen mode, show the fullscreen timer
    if (isFullScreenMode) {
      return FullScreenTimer(
        mode: state.mode,
        secondsRemaining: state.secondsRemaining,
        totalSeconds: state.currentDuration,
        onExit: _exitFullScreenMode,
        onPause: notifier.pauseTimer,
        onResume: notifier.startTimer,
        isRunning: state.isRunning,
      );
    }

    final Color modeColor = _getModeColor(state.mode);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildModeButton("Focus", TimerMode.work),
                  const SizedBox(width: 20),
                  _buildModeButton("Break", TimerMode.shortBreak),
                  const SizedBox(width: 20),
                  _buildModeButton("Rest", TimerMode.longBreak),
                ],
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: _selectTaskFromList,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade800,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          state.currentTask,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const Icon(Icons.edit, color: Colors.grey, size: 16),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 280,
                        height: 280,
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return CircularProgressIndicator(
                              value: 1 - _animationController.value,
                              strokeWidth: 4, // Thinner for minimalist look
                              backgroundColor: Colors.grey.shade900,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                modeColor,
                              ),
                            );
                          },
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _formatTime(state.secondsRemaining),
                            style: const TextStyle(
                              fontSize: 68,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _getModeText(state.mode),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey.shade400,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.replay, size: 20),
                      onPressed: notifier.resetTimer,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: IconButton(
                        icon: Icon(
                          state.isRunning ? Icons.pause : Icons.play_arrow,
                          size: 32,
                        ),
                        onPressed: () {
                          if (state.isRunning) {
                            notifier.pauseTimer();
                          } else {
                            notifier.startTimer();
                          }
                        },
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: const Icon(Icons.skip_next, size: 20),
                      onPressed: notifier.skipToNext,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "${(state.completedPomodoros)}",
                  style: const TextStyle(
                    fontSize: 24,
                    letterSpacing: 2,
                    color: Colors.white54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeButton(String label, TimerMode mode) {
    final state = ref.watch(pomodoroProvider);
    final notifier = ref.read(pomodoroProvider.notifier);

    final bool isActive = state.mode == mode;

    return TextButton(
      onPressed: () => notifier.changeMode(mode),
      style: TextButton.styleFrom(
        foregroundColor: isActive ? Colors.white : Colors.grey,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isActive ? FontWeight.normal : FontWeight.w300,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
