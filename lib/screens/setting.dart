import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomato/provider/pomodoro.dart';
import 'package:tomato/provider/setting.dart';
import 'package:tomato/provider/sound_setting.dart';
import 'package:tomato/provider/stats.dart';
import 'package:tomato/provider/task_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pomodoroState = ref.watch(pomodoroProvider);
    final pomodoroNotifier = ref.read(pomodoroProvider.notifier);
    final soundSettings = ref.watch(soundSettingProvider);
    final soundSettingsNotifier = ref.read(soundSettingProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          // Timer settings section
          const Text(
            'Timer Settings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildTimerDurationSetting(
            context,
            ref,
            'Work Duration',
            pomodoroState.workDuration ~/ 60,
            (value) =>
                pomodoroNotifier.updateTimerSettings(workDuration: value * 60),
          ),
          const SizedBox(height: 12),
          _buildTimerDurationSetting(
            context,
            ref,
            'Short Break Duration',
            pomodoroState.shortBreakDuration ~/ 60,
            (value) => pomodoroNotifier.updateTimerSettings(
              shortBreakDuration: value * 60,
            ),
          ),
          const SizedBox(height: 12),
          _buildTimerDurationSetting(
            context,
            ref,
            'Long Break Duration',
            pomodoroState.longBreakDuration ~/ 60,
            (value) => pomodoroNotifier.updateTimerSettings(
              longBreakDuration: value * 60,
            ),
          ),

          const SizedBox(height: 16),

          // Sound settings section
          const Text(
            'Sound Settings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Timer Completion Sound'),
            subtitle: const Text('Play sound when timer completes'),
            value: soundSettings.playSound,
            onChanged: (_) => soundSettingsNotifier.toggleSound(),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Background Sound'),
            subtitle: const Text('Play ambient sound during focus sessions'),
            value: soundSettings.playBackgroundSound,
            onChanged: (_) => soundSettingsNotifier.toggleBackgroundSound(),
          ),

          // Only show these settings if sounds are enabled
          if (soundSettings.playSound || soundSettings.playBackgroundSound) ...[
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Timer Sound'),
              subtitle: const Text('Select sound for timer completion'),
              trailing: DropdownButton<String>(
                value: soundSettings.timerCompletionSound,
                onChanged: (value) {
                  if (value != null) {
                    soundSettingsNotifier.updateTimerSound(value);
                  }
                },
                items: const [
                  DropdownMenuItem(value: 'bell', child: Text('Bell')),
                  DropdownMenuItem(value: 'chime', child: Text('Chime')),
                  DropdownMenuItem(value: 'digital', child: Text('Digital')),
                  DropdownMenuItem(
                    value: 'notification',
                    child: Text('Notification'),
                  ),
                ],
              ),
            ),

            if (soundSettings.playBackgroundSound)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Background Sound'),
                subtitle: const Text('Select ambient sound for focus'),
                trailing: DropdownButton<String>(
                  value: soundSettings.backgroundSoundType,
                  onChanged: (value) {
                    if (value != null) {
                      soundSettingsNotifier.updateBackgroundSound(value);
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 'white_noise',
                      child: Text('White Noise'),
                    ),
                    DropdownMenuItem(value: 'rain', child: Text('Rain')),
                    DropdownMenuItem(value: 'forest', child: Text('Forest')),
                    DropdownMenuItem(value: 'cafe', child: Text('Cafe')),
                    DropdownMenuItem(value: 'ocean', child: Text('Ocean')),
                  ],
                ),
              ),

            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Volume'),
              subtitle: Slider(
                value: soundSettings.volume,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                onChanged: (value) => soundSettingsNotifier.updateVolume(value),
              ),
              trailing: Text('${(soundSettings.volume * 100).round()}%'),
            ),
          ],

          const SizedBox(height: 16),

          // Appearance settings
          const Text(
            'Appearance',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Dark Theme'),
            value: ref.watch(settingProvider).useDarkTheme,
            onChanged:
                (_) => ref.read(settingProvider.notifier).toggleDarkTheme(),
          ),

          const SizedBox(height: 24),

          ElevatedButton.icon(
            icon: const Icon(Icons.delete_forever),
            label: const Text('Clear All Data'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade800,
              foregroundColor: Colors.white,
            ),
            onPressed: () => _showClearDataConfirmation(context, ref),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerDurationSetting(
    BuildContext context,
    WidgetRef ref,
    String label,
    int currentValue,
    Function(int) onChanged,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      subtitle: Text('$currentValue minutes'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 18),
            onPressed:
                currentValue > 1 ? () => onChanged(currentValue - 1) : null,
          ),
          Text(
            '$currentValue',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.add, size: 18),
            onPressed: () => onChanged(currentValue + 1),
          ),
        ],
      ),
    );
  }

  void _showClearDataConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Clear All Data?'),
            content: const Text(
              'This will delete all your tasks, templates, and focus statistics. This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('CANCEL'),
              ),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                onPressed: () {
                  // Clear all data
                  ref.read(tasksProvider.notifier).clearTasks();
                  ref.read(statsProvider.notifier).clearStats();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All data has been cleared')),
                  );
                },
                child: const Text('CLEAR ALL DATA'),
              ),
            ],
          ),
    );
  }
}
