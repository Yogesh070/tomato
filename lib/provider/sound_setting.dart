import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sound_setting.g.dart';

class SoundSettings {
  final bool playSound;
  final bool playBackgroundSound;
  final String timerCompletionSound;
  final String backgroundSoundType;
  final double volume;

  const SoundSettings({
    this.playSound = true,
    this.playBackgroundSound = false,
    this.timerCompletionSound = 'bell',
    this.backgroundSoundType = 'white_noise',
    this.volume = 0.7,
  });

  factory SoundSettings.initial() {
    return const SoundSettings();
  }

  SoundSettings copyWith({
    bool? playSound,
    bool? playBackgroundSound,
    String? timerCompletionSound,
    String? backgroundSoundType,
    double? volume,
  }) {
    return SoundSettings(
      playSound: playSound ?? this.playSound,
      playBackgroundSound: playBackgroundSound ?? this.playBackgroundSound,
      timerCompletionSound: timerCompletionSound ?? this.timerCompletionSound,
      backgroundSoundType: backgroundSoundType ?? this.backgroundSoundType,
      volume: volume ?? this.volume,
    );
  }
}

@riverpod
class SoundSetting extends _$SoundSetting {
  @override
  SoundSettings build() {
    return SoundSettings.initial();
  }

  void toggleSound() {
    state = state.copyWith(playSound: !state.playSound);
  }

  void toggleBackgroundSound() {
    state = state.copyWith(playBackgroundSound: !state.playBackgroundSound);
  }

  void updateTimerSound(String sound) {
    state = state.copyWith(timerCompletionSound: sound);
  }

  void updateBackgroundSound(String sound) {
    state = state.copyWith(backgroundSoundType: sound);
  }

  void updateVolume(double volume) {
    state = state.copyWith(volume: volume);
  }
}
