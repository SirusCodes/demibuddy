import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

enum TaskType { medicine, diet, call, meet, other, play, sleep }

@JsonSerializable()
class TaskModel {
  final String title, message;
  final bool isCompleted;
  final TaskType type;
  final DateTime date;

  const TaskModel({
    required this.title,
    required this.message,
    required this.isCompleted,
    required this.type,
    required this.date,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  TaskModel copyWith({
    String? title,
    String? message,
    bool? isCompleted,
    TaskType? type,
    DateTime? date,
  }) {
    return TaskModel(
      title: title ?? this.title,
      message: message ?? this.message,
      isCompleted: isCompleted ?? this.isCompleted,
      type: type ?? this.type,
      date: date ?? this.date,
    );
  }
}
