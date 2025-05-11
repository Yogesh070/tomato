import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setting.g.dart';
part 'setting.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const SettingsState._();

  const factory SettingsState({
    required bool useDarkTheme,
    required bool playSound,
    required bool enableNotifications,
    required String soundTheme,
  }) = _SettingsState;

  factory SettingsState.initial() {
    return const SettingsState(
      useDarkTheme: true,
      playSound: true,
      enableNotifications: true,
      soundTheme: 'default',
    );
  }
}

@riverpod
class Setting extends _$Setting {
  @override
  SettingsState build() {
    return SettingsState.initial();
  }

  void toggleDarkTheme() {
    state = state.copyWith(useDarkTheme: !state.useDarkTheme);
  }

  void toggleSound() {
    state = state.copyWith(playSound: !state.playSound);
  }

  void toggleNotifications() {
    state = state.copyWith(enableNotifications: !state.enableNotifications);
  }

  void updateSoundTheme(String theme) {
    state = state.copyWith(soundTheme: theme);
  }
}
