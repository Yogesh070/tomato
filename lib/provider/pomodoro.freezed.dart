// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pomodoro.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PomodoroState {

 TimerMode get mode; int get secondsRemaining; bool get isRunning; int get completedPomodoros; String get currentTask; int get workDuration; int get shortBreakDuration; int get longBreakDuration;
/// Create a copy of PomodoroState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PomodoroStateCopyWith<PomodoroState> get copyWith => _$PomodoroStateCopyWithImpl<PomodoroState>(this as PomodoroState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PomodoroState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.secondsRemaining, secondsRemaining) || other.secondsRemaining == secondsRemaining)&&(identical(other.isRunning, isRunning) || other.isRunning == isRunning)&&(identical(other.completedPomodoros, completedPomodoros) || other.completedPomodoros == completedPomodoros)&&(identical(other.currentTask, currentTask) || other.currentTask == currentTask)&&(identical(other.workDuration, workDuration) || other.workDuration == workDuration)&&(identical(other.shortBreakDuration, shortBreakDuration) || other.shortBreakDuration == shortBreakDuration)&&(identical(other.longBreakDuration, longBreakDuration) || other.longBreakDuration == longBreakDuration));
}


@override
int get hashCode => Object.hash(runtimeType,mode,secondsRemaining,isRunning,completedPomodoros,currentTask,workDuration,shortBreakDuration,longBreakDuration);

@override
String toString() {
  return 'PomodoroState(mode: $mode, secondsRemaining: $secondsRemaining, isRunning: $isRunning, completedPomodoros: $completedPomodoros, currentTask: $currentTask, workDuration: $workDuration, shortBreakDuration: $shortBreakDuration, longBreakDuration: $longBreakDuration)';
}


}

/// @nodoc
abstract mixin class $PomodoroStateCopyWith<$Res>  {
  factory $PomodoroStateCopyWith(PomodoroState value, $Res Function(PomodoroState) _then) = _$PomodoroStateCopyWithImpl;
@useResult
$Res call({
 TimerMode mode, int secondsRemaining, bool isRunning, int completedPomodoros, String currentTask, int workDuration, int shortBreakDuration, int longBreakDuration
});




}
/// @nodoc
class _$PomodoroStateCopyWithImpl<$Res>
    implements $PomodoroStateCopyWith<$Res> {
  _$PomodoroStateCopyWithImpl(this._self, this._then);

  final PomodoroState _self;
  final $Res Function(PomodoroState) _then;

/// Create a copy of PomodoroState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? secondsRemaining = null,Object? isRunning = null,Object? completedPomodoros = null,Object? currentTask = null,Object? workDuration = null,Object? shortBreakDuration = null,Object? longBreakDuration = null,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as TimerMode,secondsRemaining: null == secondsRemaining ? _self.secondsRemaining : secondsRemaining // ignore: cast_nullable_to_non_nullable
as int,isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,completedPomodoros: null == completedPomodoros ? _self.completedPomodoros : completedPomodoros // ignore: cast_nullable_to_non_nullable
as int,currentTask: null == currentTask ? _self.currentTask : currentTask // ignore: cast_nullable_to_non_nullable
as String,workDuration: null == workDuration ? _self.workDuration : workDuration // ignore: cast_nullable_to_non_nullable
as int,shortBreakDuration: null == shortBreakDuration ? _self.shortBreakDuration : shortBreakDuration // ignore: cast_nullable_to_non_nullable
as int,longBreakDuration: null == longBreakDuration ? _self.longBreakDuration : longBreakDuration // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _PomodoroState extends PomodoroState {
  const _PomodoroState({required this.mode, required this.secondsRemaining, required this.isRunning, required this.completedPomodoros, required this.currentTask, required this.workDuration, required this.shortBreakDuration, required this.longBreakDuration}): super._();
  

@override final  TimerMode mode;
@override final  int secondsRemaining;
@override final  bool isRunning;
@override final  int completedPomodoros;
@override final  String currentTask;
@override final  int workDuration;
@override final  int shortBreakDuration;
@override final  int longBreakDuration;

/// Create a copy of PomodoroState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PomodoroStateCopyWith<_PomodoroState> get copyWith => __$PomodoroStateCopyWithImpl<_PomodoroState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PomodoroState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.secondsRemaining, secondsRemaining) || other.secondsRemaining == secondsRemaining)&&(identical(other.isRunning, isRunning) || other.isRunning == isRunning)&&(identical(other.completedPomodoros, completedPomodoros) || other.completedPomodoros == completedPomodoros)&&(identical(other.currentTask, currentTask) || other.currentTask == currentTask)&&(identical(other.workDuration, workDuration) || other.workDuration == workDuration)&&(identical(other.shortBreakDuration, shortBreakDuration) || other.shortBreakDuration == shortBreakDuration)&&(identical(other.longBreakDuration, longBreakDuration) || other.longBreakDuration == longBreakDuration));
}


@override
int get hashCode => Object.hash(runtimeType,mode,secondsRemaining,isRunning,completedPomodoros,currentTask,workDuration,shortBreakDuration,longBreakDuration);

@override
String toString() {
  return 'PomodoroState(mode: $mode, secondsRemaining: $secondsRemaining, isRunning: $isRunning, completedPomodoros: $completedPomodoros, currentTask: $currentTask, workDuration: $workDuration, shortBreakDuration: $shortBreakDuration, longBreakDuration: $longBreakDuration)';
}


}

/// @nodoc
abstract mixin class _$PomodoroStateCopyWith<$Res> implements $PomodoroStateCopyWith<$Res> {
  factory _$PomodoroStateCopyWith(_PomodoroState value, $Res Function(_PomodoroState) _then) = __$PomodoroStateCopyWithImpl;
@override @useResult
$Res call({
 TimerMode mode, int secondsRemaining, bool isRunning, int completedPomodoros, String currentTask, int workDuration, int shortBreakDuration, int longBreakDuration
});




}
/// @nodoc
class __$PomodoroStateCopyWithImpl<$Res>
    implements _$PomodoroStateCopyWith<$Res> {
  __$PomodoroStateCopyWithImpl(this._self, this._then);

  final _PomodoroState _self;
  final $Res Function(_PomodoroState) _then;

/// Create a copy of PomodoroState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? secondsRemaining = null,Object? isRunning = null,Object? completedPomodoros = null,Object? currentTask = null,Object? workDuration = null,Object? shortBreakDuration = null,Object? longBreakDuration = null,}) {
  return _then(_PomodoroState(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as TimerMode,secondsRemaining: null == secondsRemaining ? _self.secondsRemaining : secondsRemaining // ignore: cast_nullable_to_non_nullable
as int,isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,completedPomodoros: null == completedPomodoros ? _self.completedPomodoros : completedPomodoros // ignore: cast_nullable_to_non_nullable
as int,currentTask: null == currentTask ? _self.currentTask : currentTask // ignore: cast_nullable_to_non_nullable
as String,workDuration: null == workDuration ? _self.workDuration : workDuration // ignore: cast_nullable_to_non_nullable
as int,shortBreakDuration: null == shortBreakDuration ? _self.shortBreakDuration : shortBreakDuration // ignore: cast_nullable_to_non_nullable
as int,longBreakDuration: null == longBreakDuration ? _self.longBreakDuration : longBreakDuration // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
