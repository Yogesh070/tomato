// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsState {

 bool get useDarkTheme; bool get playSound; bool get enableNotifications; String get soundTheme;
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsStateCopyWith<SettingsState> get copyWith => _$SettingsStateCopyWithImpl<SettingsState>(this as SettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState&&(identical(other.useDarkTheme, useDarkTheme) || other.useDarkTheme == useDarkTheme)&&(identical(other.playSound, playSound) || other.playSound == playSound)&&(identical(other.enableNotifications, enableNotifications) || other.enableNotifications == enableNotifications)&&(identical(other.soundTheme, soundTheme) || other.soundTheme == soundTheme));
}


@override
int get hashCode => Object.hash(runtimeType,useDarkTheme,playSound,enableNotifications,soundTheme);

@override
String toString() {
  return 'SettingsState(useDarkTheme: $useDarkTheme, playSound: $playSound, enableNotifications: $enableNotifications, soundTheme: $soundTheme)';
}


}

/// @nodoc
abstract mixin class $SettingsStateCopyWith<$Res>  {
  factory $SettingsStateCopyWith(SettingsState value, $Res Function(SettingsState) _then) = _$SettingsStateCopyWithImpl;
@useResult
$Res call({
 bool useDarkTheme, bool playSound, bool enableNotifications, String soundTheme
});




}
/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._self, this._then);

  final SettingsState _self;
  final $Res Function(SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? useDarkTheme = null,Object? playSound = null,Object? enableNotifications = null,Object? soundTheme = null,}) {
  return _then(_self.copyWith(
useDarkTheme: null == useDarkTheme ? _self.useDarkTheme : useDarkTheme // ignore: cast_nullable_to_non_nullable
as bool,playSound: null == playSound ? _self.playSound : playSound // ignore: cast_nullable_to_non_nullable
as bool,enableNotifications: null == enableNotifications ? _self.enableNotifications : enableNotifications // ignore: cast_nullable_to_non_nullable
as bool,soundTheme: null == soundTheme ? _self.soundTheme : soundTheme // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _SettingsState extends SettingsState {
  const _SettingsState({required this.useDarkTheme, required this.playSound, required this.enableNotifications, required this.soundTheme}): super._();
  

@override final  bool useDarkTheme;
@override final  bool playSound;
@override final  bool enableNotifications;
@override final  String soundTheme;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsStateCopyWith<_SettingsState> get copyWith => __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsState&&(identical(other.useDarkTheme, useDarkTheme) || other.useDarkTheme == useDarkTheme)&&(identical(other.playSound, playSound) || other.playSound == playSound)&&(identical(other.enableNotifications, enableNotifications) || other.enableNotifications == enableNotifications)&&(identical(other.soundTheme, soundTheme) || other.soundTheme == soundTheme));
}


@override
int get hashCode => Object.hash(runtimeType,useDarkTheme,playSound,enableNotifications,soundTheme);

@override
String toString() {
  return 'SettingsState(useDarkTheme: $useDarkTheme, playSound: $playSound, enableNotifications: $enableNotifications, soundTheme: $soundTheme)';
}


}

/// @nodoc
abstract mixin class _$SettingsStateCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(_SettingsState value, $Res Function(_SettingsState) _then) = __$SettingsStateCopyWithImpl;
@override @useResult
$Res call({
 bool useDarkTheme, bool playSound, bool enableNotifications, String soundTheme
});




}
/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(this._self, this._then);

  final _SettingsState _self;
  final $Res Function(_SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? useDarkTheme = null,Object? playSound = null,Object? enableNotifications = null,Object? soundTheme = null,}) {
  return _then(_SettingsState(
useDarkTheme: null == useDarkTheme ? _self.useDarkTheme : useDarkTheme // ignore: cast_nullable_to_non_nullable
as bool,playSound: null == playSound ? _self.playSound : playSound // ignore: cast_nullable_to_non_nullable
as bool,enableNotifications: null == enableNotifications ? _self.enableNotifications : enableNotifications // ignore: cast_nullable_to_non_nullable
as bool,soundTheme: null == soundTheme ? _self.soundTheme : soundTheme // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
