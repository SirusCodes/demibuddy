// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json[r'$id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      isCompleted: json['isCompleted'] as bool,
      type: $enumDecode(_$TaskTypeEnumMap, json['type']),
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      r'$id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'isCompleted': instance.isCompleted,
      'type': _$TaskTypeEnumMap[instance.type],
      'date': instance.date.toIso8601String(),
    };

const _$TaskTypeEnumMap = {
  TaskType.medicine: 'medicine',
  TaskType.diet: 'diet',
  TaskType.call: 'call',
  TaskType.meet: 'meet',
  TaskType.other: 'other',
  TaskType.play: 'play',
  TaskType.sleep: 'sleep',
};
