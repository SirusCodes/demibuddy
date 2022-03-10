import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:demicare/screens/game_screen.dart';
import 'package:demicare/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/task_model/task_model.dart';
import '../utils/init_get_it.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<TaskModel>? _tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
      body: FutureBuilder<DocumentList>(
        future: getIt.get<Database>().listDocuments(
          collectionId: "tasks",
          queries: [Query.equal("patient", userId)],
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final tasks = snapshot.data;
            _tasks = tasks!.convertTo(
              (p0) => TaskModel.fromJson(p0 as Map<String, dynamic>),
            )..sort((a, b) => a.date.compareTo(b.date));

            return ListView.builder(
              itemCount: tasks.total,
              itemBuilder: (context, index) {
                return _buildTask(index);
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
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

  _actionByType(TaskModel task) {
    if (task.isCompleted) return;
    switch (task.type) {
      case TaskType.call:
        launch("tel:${task.message}");
        break;
      case TaskType.meet:
        launch(task.message);
        break;
      case TaskType.play:
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const GameScreen()),
        );
      case TaskType.medicine:
      case TaskType.diet:
      case TaskType.other:
      case TaskType.sleep:
    }
  }

  Widget _buildTask(int index) {
    final data = _tasks![index];
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
      onTap: () async {
        final updatedTask = await _updateTaskStatus(data);
        setState(() => _tasks![index] = updatedTask);
        _actionByType(data);
      },
      leading: Icon(_getIconByType(data.type)),
      trailing: Checkbox(
        value: data.isCompleted,
        onChanged: (value) async {
          if (value == null) return;
          final updatedTask = await _updateTaskStatus(data);
          setState(() => _tasks![index] = updatedTask);
          _actionByType(data);
        },
      ),
    );
  }

  Future<TaskModel> _updateTaskStatus(TaskModel task) {
    return getIt
        .get<Database>()
        .updateDocument(
          collectionId: "tasks",
          documentId: task.id,
          data: task.copyWith(isCompleted: !task.isCompleted).toJson(),
        )
        .then((value) => value.convertTo(
              (p0) => TaskModel.fromJson(p0 as Map<String, dynamic>),
            ));
  }
}
