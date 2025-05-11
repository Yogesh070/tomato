import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tomato/provider/pomodoro.dart';

part 'stats.g.dart';
part 'stats.freezed.dart';

@freezed
abstract class FocusSession with _$FocusSession {
  const FocusSession._();

  const factory FocusSession({
    required String id,
    required DateTime startTime,
    required DateTime endTime,
    required TimerMode mode,
    required String taskId,
  }) = _FocusSession;

  int get durationMinutes => endTime.difference(startTime).inMinutes;

  bool get isWorkSession => mode == TimerMode.work;
}

@freezed
abstract class StatsState with _$StatsState {
  const StatsState._();

  const factory StatsState({required List<FocusSession> sessions}) =
      _StatsState;

  factory StatsState.initial() {
    return const StatsState(sessions: []);
  }

  int get todayFocusMinutes {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return sessions
        .where((s) => s.isWorkSession && s.startTime.isAfter(today))
        .fold(0, (sum, session) => sum + session.durationMinutes);
  }

  // Focus time by day for the week
  Map<DateTime, int> get weeklyFocusMinutes {
    final result = <DateTime, int>{};
    final now = DateTime.now();

    // Get start of week (7 days ago)
    final weekStart = DateTime(now.year, now.month, now.day - 7);

    // Filter sessions from this week
    final thisWeekSessions = sessions.where(
      (s) => s.isWorkSession && s.startTime.isAfter(weekStart),
    );

    // Group by day
    for (final session in thisWeekSessions) {
      final day = DateTime(
        session.startTime.year,
        session.startTime.month,
        session.startTime.day,
      );

      result[day] = (result[day] ?? 0) + session.durationMinutes;
    }

    return result;
  }

  Map<DateTime, int> get monthlyFocusMinutes {
    final result = <DateTime, int>{};
    final now = DateTime.now();

    // Get start of last 6 months
    final monthsStart = DateTime(now.year, now.month - 6, 1);

    // Filter sessions from last 6 months
    final recentSessions = sessions.where(
      (s) => s.isWorkSession && s.startTime.isAfter(monthsStart),
    );

    // Group by month
    for (final session in recentSessions) {
      final month = DateTime(
        session.startTime.year,
        session.startTime.month,
        1,
      );

      result[month] = (result[month] ?? 0) + session.durationMinutes;
    }

    return result;
  }
}

@riverpod
class Stats extends _$Stats {
  @override
  StatsState build() {
    return StatsState.initial();
  }

  void addSession(FocusSession session) {
    state = state.copyWith(sessions: [...state.sessions, session]);
  }

  void clearStats() {
    state = StatsState.initial();
  }
}
