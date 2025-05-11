// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Task {

 String get id; String get title; String? get description; int get estimatedPomodoros; int get completedPomodoros; DateTime? get createdAt; DateTime? get completedAt; bool get isCompleted; bool get isTemplate;
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCopyWith<Task> get copyWith => _$TaskCopyWithImpl<Task>(this as Task, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Task&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.estimatedPomodoros, estimatedPomodoros) || other.estimatedPomodoros == estimatedPomodoros)&&(identical(other.completedPomodoros, completedPomodoros) || other.completedPomodoros == completedPomodoros)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.isTemplate, isTemplate) || other.isTemplate == isTemplate));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,estimatedPomodoros,completedPomodoros,createdAt,completedAt,isCompleted,isTemplate);

@override
String toString() {
  return 'Task(id: $id, title: $title, description: $description, estimatedPomodoros: $estimatedPomodoros, completedPomodoros: $completedPomodoros, createdAt: $createdAt, completedAt: $completedAt, isCompleted: $isCompleted, isTemplate: $isTemplate)';
}


}

/// @nodoc
abstract mixin class $TaskCopyWith<$Res>  {
  factory $TaskCopyWith(Task value, $Res Function(Task) _then) = _$TaskCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, int estimatedPomodoros, int completedPomodoros, DateTime? createdAt, DateTime? completedAt, bool isCompleted, bool isTemplate
});




}
/// @nodoc
class _$TaskCopyWithImpl<$Res>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._self, this._then);

  final Task _self;
  final $Res Function(Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? estimatedPomodoros = null,Object? completedPomodoros = null,Object? createdAt = freezed,Object? completedAt = freezed,Object? isCompleted = null,Object? isTemplate = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,estimatedPomodoros: null == estimatedPomodoros ? _self.estimatedPomodoros : estimatedPomodoros // ignore: cast_nullable_to_non_nullable
as int,completedPomodoros: null == completedPomodoros ? _self.completedPomodoros : completedPomodoros // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,isTemplate: null == isTemplate ? _self.isTemplate : isTemplate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _Task implements Task {
  const _Task({required this.id, required this.title, this.description, this.estimatedPomodoros = 1, this.completedPomodoros = 0, this.createdAt, this.completedAt, this.isCompleted = false, this.isTemplate = false});
  

@override final  String id;
@override final  String title;
@override final  String? description;
@override@JsonKey() final  int estimatedPomodoros;
@override@JsonKey() final  int completedPomodoros;
@override final  DateTime? createdAt;
@override final  DateTime? completedAt;
@override@JsonKey() final  bool isCompleted;
@override@JsonKey() final  bool isTemplate;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCopyWith<_Task> get copyWith => __$TaskCopyWithImpl<_Task>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Task&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.estimatedPomodoros, estimatedPomodoros) || other.estimatedPomodoros == estimatedPomodoros)&&(identical(other.completedPomodoros, completedPomodoros) || other.completedPomodoros == completedPomodoros)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.isTemplate, isTemplate) || other.isTemplate == isTemplate));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,estimatedPomodoros,completedPomodoros,createdAt,completedAt,isCompleted,isTemplate);

@override
String toString() {
  return 'Task(id: $id, title: $title, description: $description, estimatedPomodoros: $estimatedPomodoros, completedPomodoros: $completedPomodoros, createdAt: $createdAt, completedAt: $completedAt, isCompleted: $isCompleted, isTemplate: $isTemplate)';
}


}

/// @nodoc
abstract mixin class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) _then) = __$TaskCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, int estimatedPomodoros, int completedPomodoros, DateTime? createdAt, DateTime? completedAt, bool isCompleted, bool isTemplate
});




}
/// @nodoc
class __$TaskCopyWithImpl<$Res>
    implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(this._self, this._then);

  final _Task _self;
  final $Res Function(_Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? estimatedPomodoros = null,Object? completedPomodoros = null,Object? createdAt = freezed,Object? completedAt = freezed,Object? isCompleted = null,Object? isTemplate = null,}) {
  return _then(_Task(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,estimatedPomodoros: null == estimatedPomodoros ? _self.estimatedPomodoros : estimatedPomodoros // ignore: cast_nullable_to_non_nullable
as int,completedPomodoros: null == completedPomodoros ? _self.completedPomodoros : completedPomodoros // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,isTemplate: null == isTemplate ? _self.isTemplate : isTemplate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$TasksState {

 List<Task> get tasks; List<Task> get templates; String? get activeTaskId;
/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TasksStateCopyWith<TasksState> get copyWith => _$TasksStateCopyWithImpl<TasksState>(this as TasksState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TasksState&&const DeepCollectionEquality().equals(other.tasks, tasks)&&const DeepCollectionEquality().equals(other.templates, templates)&&(identical(other.activeTaskId, activeTaskId) || other.activeTaskId == activeTaskId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(tasks),const DeepCollectionEquality().hash(templates),activeTaskId);

@override
String toString() {
  return 'TasksState(tasks: $tasks, templates: $templates, activeTaskId: $activeTaskId)';
}


}

/// @nodoc
abstract mixin class $TasksStateCopyWith<$Res>  {
  factory $TasksStateCopyWith(TasksState value, $Res Function(TasksState) _then) = _$TasksStateCopyWithImpl;
@useResult
$Res call({
 List<Task> tasks, List<Task> templates, String? activeTaskId
});




}
/// @nodoc
class _$TasksStateCopyWithImpl<$Res>
    implements $TasksStateCopyWith<$Res> {
  _$TasksStateCopyWithImpl(this._self, this._then);

  final TasksState _self;
  final $Res Function(TasksState) _then;

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tasks = null,Object? templates = null,Object? activeTaskId = freezed,}) {
  return _then(_self.copyWith(
tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,templates: null == templates ? _self.templates : templates // ignore: cast_nullable_to_non_nullable
as List<Task>,activeTaskId: freezed == activeTaskId ? _self.activeTaskId : activeTaskId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _TasksState extends TasksState {
  const _TasksState({required final  List<Task> tasks, required final  List<Task> templates, this.activeTaskId}): _tasks = tasks,_templates = templates,super._();
  

 final  List<Task> _tasks;
@override List<Task> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}

 final  List<Task> _templates;
@override List<Task> get templates {
  if (_templates is EqualUnmodifiableListView) return _templates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_templates);
}

@override final  String? activeTaskId;

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TasksStateCopyWith<_TasksState> get copyWith => __$TasksStateCopyWithImpl<_TasksState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TasksState&&const DeepCollectionEquality().equals(other._tasks, _tasks)&&const DeepCollectionEquality().equals(other._templates, _templates)&&(identical(other.activeTaskId, activeTaskId) || other.activeTaskId == activeTaskId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tasks),const DeepCollectionEquality().hash(_templates),activeTaskId);

@override
String toString() {
  return 'TasksState(tasks: $tasks, templates: $templates, activeTaskId: $activeTaskId)';
}


}

/// @nodoc
abstract mixin class _$TasksStateCopyWith<$Res> implements $TasksStateCopyWith<$Res> {
  factory _$TasksStateCopyWith(_TasksState value, $Res Function(_TasksState) _then) = __$TasksStateCopyWithImpl;
@override @useResult
$Res call({
 List<Task> tasks, List<Task> templates, String? activeTaskId
});




}
/// @nodoc
class __$TasksStateCopyWithImpl<$Res>
    implements _$TasksStateCopyWith<$Res> {
  __$TasksStateCopyWithImpl(this._self, this._then);

  final _TasksState _self;
  final $Res Function(_TasksState) _then;

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tasks = null,Object? templates = null,Object? activeTaskId = freezed,}) {
  return _then(_TasksState(
tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,templates: null == templates ? _self._templates : templates // ignore: cast_nullable_to_non_nullable
as List<Task>,activeTaskId: freezed == activeTaskId ? _self.activeTaskId : activeTaskId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
