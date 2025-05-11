import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tomato/provider/stats.dart';
import 'package:tomato/provider/task_provider.dart';

part 'pomodoro.freezed.dart';
part 'pomodoro.g.dart';

enum TimerMode { work, shortBreak, longBreak }

@freezed
abstract class PomodoroState with _$PomodoroState {
  const PomodoroState._();

  const factory PomodoroState({
    required TimerMode mode,
    required int secondsRemaining,
    required bool isRunning,
    required int completedPomodoros,
    required String currentTask,
    required int workDuration,
    required int shortBreakDuration,
    required int longBreakDuration,
  }) = _PomodoroState;

  factory PomodoroState.initial() {
    const workDuration = 25 * 60; // 25 minutes in seconds
    return const PomodoroState(
      mode: TimerMode.work,
      secondsRemaining: workDuration,
      isRunning: false,
      completedPomodoros: 0,
      currentTask: "Focus on your task",
      workDuration: workDuration,
      shortBreakDuration: 5 * 60, // 5 minutes
      longBreakDuration: 15 * 60, // 15 minutes
    );
  }

  int get currentDuration {
    switch (mode) {
      case TimerMode.work:
        return workDuration;
      case TimerMode.shortBreak:
        return shortBreakDuration;
      case TimerMode.longBreak:
        return longBreakDuration;
    }
  }
}

@riverpod
class Pomodoro extends _$Pomodoro {
  Timer? _timer;
  DateTime? _sessionStartTime;

  @override
  PomodoroState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });

    return PomodoroState.initial();
  }

  // Start the timer
  void startTimer() {
    if (state.isRunning) return;

    // Record start time for tracking
    _sessionStartTime ??= DateTime.now();

    state = state.copyWith(isRunning: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining > 0) {
        state = state.copyWith(secondsRemaining: state.secondsRemaining - 1);
      } else {
        handleTimerCompletion();
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false);
  }

  // Reset the timer
  void resetTimer() {
    _timer?.cancel();
    _sessionStartTime = null;
    state = state.copyWith(
      secondsRemaining: state.currentDuration,
      isRunning: false,
    );
  }

  // Handle timer completion
  void handleTimerCompletion() {
    _timer?.cancel();

    // Record completed session for statistics
    if (_sessionStartTime != null) {
      final endTime = DateTime.now();
      final tasksState = ref.read(tasksProvider);
      final taskId = tasksState.activeTaskId ?? '';

      // Create a focus session record
      final session = FocusSession(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        startTime: _sessionStartTime!,
        endTime: endTime,
        mode: state.mode,
        taskId: taskId,
      );

      // Add to stats
      ref.read(statsProvider.notifier).addSession(session);

      // If this was a work session, increment the task's completed pomodoros
      if (state.mode == TimerMode.work && taskId.isNotEmpty) {
        ref.read(tasksProvider.notifier).incrementTaskPomodoros(taskId);
      }

      _sessionStartTime = null;
    }
    // Different logic based on current mode
    if (state.mode == TimerMode.work) {
      final newCompletedCount = state.completedPomodoros + 1;

      // After 4 pomodoros, take a long break, otherwise a short break
      final newMode =
          newCompletedCount % 4 == 0
              ? TimerMode.longBreak
              : TimerMode.shortBreak;

      state = state.copyWith(
        mode: newMode,
        completedPomodoros: newCompletedCount,
        isRunning: false,
      );
    } else {
      // After any break, go back to work mode
      state = state.copyWith(mode: TimerMode.work, isRunning: false);
    }

    // Reset seconds remaining to appropriate duration
    state = state.copyWith(secondsRemaining: state.currentDuration);
  }

  // Change timer mode
  void changeMode(TimerMode mode) {
    _timer?.cancel();
    _sessionStartTime = null;
    state = state.copyWith(
      mode: mode,
      secondsRemaining:
          mode == TimerMode.work
              ? state.workDuration
              : mode == TimerMode.shortBreak
              ? state.shortBreakDuration
              : state.longBreakDuration,
      isRunning: false,
    );
  }

  // Update the current task
  void updateTask(String task) {
    state = state.copyWith(
      currentTask: task.isNotEmpty ? task : "Focus on your task",
    );
  }

  // Skip to next session
  void skipToNext() {
    handleTimerCompletion();
  }

  // Update timer settings
  void updateTimerSettings({
    int? workDuration,
    int? shortBreakDuration,
    int? longBreakDuration,
  }) {
    state = state.copyWith(
      workDuration: workDuration ?? state.workDuration,
      shortBreakDuration: shortBreakDuration ?? state.shortBreakDuration,
      longBreakDuration: longBreakDuration ?? state.longBreakDuration,
    );

    // If we're updating the current mode's duration, also update seconds remaining
    if (state.mode == TimerMode.work && workDuration != null) {
      state = state.copyWith(secondsRemaining: workDuration);
    } else if (state.mode == TimerMode.shortBreak &&
        shortBreakDuration != null) {
      state = state.copyWith(secondsRemaining: shortBreakDuration);
    } else if (state.mode == TimerMode.longBreak && longBreakDuration != null) {
      state = state.copyWith(secondsRemaining: longBreakDuration);
    }
  }

  // Get estimated finish time for all tasks
  String getEstimatedFinishTime() {
    final tasksState = ref.read(tasksProvider);
    final totalMinutesLeft = tasksState.totalEstimatedMinutes;

    if (totalMinutesLeft <= 0) {
      return "No tasks scheduled";
    }

    // Calculate finish time based on current time
    final now = DateTime.now();
    final finishTime = now.add(Duration(minutes: totalMinutesLeft));

    // Format the time
    final hour = finishTime.hour;
    final minute = finishTime.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final formattedHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

    return 'Estimated finish: $formattedHour:${minute.toString().padLeft(2, '0')} $period';
  }
}
