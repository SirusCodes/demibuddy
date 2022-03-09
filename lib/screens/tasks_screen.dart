import 'package:flutter/material.dart';

import '../models/task_model/task_model.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late final List<TaskModel> _mockTask;

  @override
  void initState() {
    super.initState();
    _mockTask = [
      TaskModel(
        date: DateTime.now(),
        isCompleted: false,
        message: "message",
        title: "Call",
        type: TaskType.call,
      ),
      TaskModel(
        date: DateTime.now(),
        isCompleted: true,
        message: "message",
        title: "Diet",
        type: TaskType.diet,
      ),
      TaskModel(
        date: DateTime.now(),
        isCompleted: false,
        message: "message",
        title: "Medicine",
        type: TaskType.medicine,
      ),
      TaskModel(
        date: DateTime.now(),
        isCompleted: false,
        message: "message",
        title: "Meet",
        type: TaskType.meet,
      ),
      TaskModel(
        date: DateTime.now(),
        isCompleted: false,
        message: "message",
        title: "Other",
        type: TaskType.other,
      ),
      TaskModel(
        date: DateTime.now(),
        isCompleted: false,
        message: "message",
        title: "Medicine",
        type: TaskType.play,
      ),
      TaskModel(
        date: DateTime.now(),
        isCompleted: false,
        message: "message",
        title: "Medicine",
        type: TaskType.sleep,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
      body: ListView.builder(
        itemCount: _mockTask.length,
        itemBuilder: (context, index) {
          final data = _mockTask[index];

          return _buildTask(data, index);
        },
      ),
    );
  }

  _getIconByType(TaskType type) {
    switch (type) {
      case TaskType.medicine:
        return Icons.medication;

      case TaskType.diet:
        return Icons.food_bank;

      case TaskType.call:
        return Icons.call;
      case TaskType.meet:
        return Icons.video_call;
      case TaskType.other:
        return Icons.star_outline_sharp;
      case TaskType.play:
        return Icons.gamepad;
      case TaskType.sleep:
        return Icons.bed;
    }
  }

  Widget _buildTask(TaskModel data, int index) {
    return ListTile(
      title: Text(
        data.title,
        style: TextStyle(
          decoration: data.isCompleted //
              ? TextDecoration.lineThrough
              : null,
        ),
      ),
      subtitle: Text(data.message),
      onTap: () {
        setState(() => _mockTask[index] = data.copyWith(
              isCompleted: !data.isCompleted,
            ));
      },
      leading: Icon(_getIconByType(data.type)),
      trailing: Checkbox(
        value: data.isCompleted,
        onChanged: (value) {
          if (value == null) return;
          setState(() => _mockTask[index] = data.copyWith(
                isCompleted: !data.isCompleted,
              ));
        },
      ),
    );
  }
}
