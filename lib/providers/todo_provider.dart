import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> _todos = [];
  final _uuid = Uuid();
  DateTime _date = DateTime.now();

  get todos => _todos;
  get date => _date;

  set changeDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  void saveTodo(String task) {
    _todos = [
      ..._todos,
      TodoModel(
        id: _uuid.v4(),
        task: task.trim(),
        date: _date.toIso8601String(),
      ),
    ];
    notifyListeners();
  }

  void updateTodo(String id, String task) {
    _todos = [
      for (final todoModel in _todos)
        if (todoModel.id == id)
          TodoModel(
            id: todoModel.id,
            task: task.trim(),
            date: _date.toIso8601String(),
          )
        else
          todoModel,
    ];
    notifyListeners();
  }

  void removeTodo(TodoModel todoModel) {
    _todos = _todos.where((todo) => todo.id != todoModel.id).toList();
    notifyListeners();
  }
}
