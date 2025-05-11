import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomato/provider/stats.dart';
import 'package:tomato/provider/task_provider.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsState = ref.watch(statsProvider);
    final tasksState = ref.watch(tasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Reports'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body:
          statsState.sessions.isEmpty
              ? _buildEmptyState()
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Daily summary card
                    _buildTodaySummaryCard(statsState),

                    const SizedBox(height: 24),

                    // Weekly chart
                    const Text(
                      'Weekly Focus',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(height: 200, child: _buildWeeklyChart(statsState)),

                    const SizedBox(height: 24),

                    // Monthly summary
                    const Text(
                      'Monthly Focus',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: _buildMonthlyChart(statsState),
                    ),

                    const SizedBox(height: 24),

                    // Task completion stats if there are tasks
                    if (tasksState.tasks.isNotEmpty) ...[
                      const Text(
                        'Task Completion',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildTaskCompletionCard(tasksState),
                    ],
                  ],
                ),
              ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bar_chart, size: 80, color: Colors.grey.shade700),
          const SizedBox(height: 16),
          const Text(
            'No focus data yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Complete some Pomodoro sessions\nto see your focus statistics.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaySummaryCard(StatsState statsState) {
    final todayMinutes = statsState.todayFocusMinutes;
    final todayHours = todayMinutes ~/ 60;
    final remainingMinutes = todayMinutes % 60;

    return Card(
      color: Colors.blueGrey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today\'s Focus',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.timer, size: 48, color: Colors.orange.shade300),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todayHours > 0
                            ? '$todayHours hr ${remainingMinutes > 0 ? '$remainingMinutes min' : ''}'
                            : '$todayMinutes min',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Across ${statsState.sessions.where((s) => s.isWorkSession).length} sessions',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyChart(StatsState statsState) {
    final weekData = statsState.weeklyFocusMinutes;
    final now = DateTime.now();

    // Ensure we have data for all 7 days of the week
    final List<Map<String, dynamic>> chartData = List.generate(7, (index) {
      final day = DateTime(now.year, now.month, now.day - 6 + index);
      final dayName = _getDayName(day.weekday);
      return {'day': dayName, 'minutes': weekData[day] ?? 0};
    });

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          chartData.map((data) => data['minutes'] as int).toList(),
          chartData.map((data) => data['day'] as String).toList(),
          barColor: Colors.green,
        ),
      ),
    );
  }

  Widget _buildMonthlyChart(StatsState statsState) {
    final monthData = statsState.monthlyFocusMinutes;
    final now = DateTime.now();

    // Get last 6 months
    final List<Map<String, dynamic>> chartData = List.generate(6, (index) {
      final month = DateTime(now.year, now.month - 5 + index);
      final monthName = _getMonthName(month.month);
      return {'month': monthName, 'minutes': monthData[month] ?? 0};
    });

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          chartData.map((data) => data['minutes'] as int).toList(),
          chartData.map((data) => data['month'] as String).toList(),
          barColor: Colors.blue,
          isHorizontalLabel: false,
        ),
      ),
    );
  }

  // Continuation of Reports Screen

  Widget _buildTaskCompletionCard(TasksState tasksState) {
    final completedTasks = tasksState.tasks.where((t) => t.isCompleted).length;
    final totalTasks = tasksState.tasks.length;
    final completionRate =
        totalTasks > 0 ? (completedTasks / totalTasks * 100).round() : 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$completedTasks/$totalTasks Tasks Completed',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '$completionRate%',
                  style: TextStyle(
                    color: Colors.green.shade300,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: totalTasks > 0 ? completedTasks / totalTasks : 0,
              backgroundColor: Colors.grey.shade800,
              color: Colors.green.shade300,
              minHeight: 10,
            ),
          ],
        ),
      ),
    );
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }
}

class BarChart extends StatelessWidget {
  final List<int> data;
  final List<String> labels;
  final Color barColor;
  final bool isHorizontalLabel;

  const BarChart(
    this.data,
    this.labels, {
    required this.barColor,
    this.isHorizontalLabel = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Find the highest value for scaling
    final maxValue = data.isEmpty ? 0 : data.reduce((a, b) => a > b ? a : b);

    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(data.length, (index) {
              final value = data[index];
              final percentage = maxValue > 0 ? value / maxValue : 0;

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Data label (only show if there's a value)
                      if (value > 0)
                        Text(
                          value.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white70,
                          ),
                        ),
                      const SizedBox(height: 4),
                      // Bar
                      Container(
                        height: percentage * 120, // Scale to max 120 height
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: barColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),

        // X-axis labels
        SizedBox(
          height: 30,
          child:
              isHorizontalLabel
                  ? Row(
                    children: List.generate(labels.length, (index) {
                      return Expanded(
                        child: Text(
                          labels[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white70,
                          ),
                        ),
                      );
                    }),
                  )
                  : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: labels.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width:
                            (MediaQuery.of(context).size.width - 32) /
                            labels.length,
                        child: Text(
                          labels[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white70,
                          ),
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
