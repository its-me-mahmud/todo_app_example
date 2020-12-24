import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  var _uuid = Uuid();
  String _id;
  String _task;
  DateTime _date;
  List<TodoModel> _todos = [];

  String get todo => _task;
  DateTime get date => _date;
  List<TodoModel> get todos => _todos;

  set changeDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  set changeTask(String task) {
    _task = task;
    notifyListeners();
  }

  loadTodos(TodoModel todoModel) {
    if (todoModel != null) {
      _id = todoModel.id;
      _task = todoModel.task;
      _date = DateTime.parse(todoModel.date);
    } else {
      _id = null;
      _task = null;
      _date = DateTime.now();
    }
  }

  void saveTodo() {
    if (_id == null) {
      _todos.add(
        TodoModel(
          id: _uuid.v4(),
          task: _task,
          date: _date.toIso8601String(),
        ),
      );
      // print('add: ${_uuid.v4().toString()}');
      notifyListeners();
    }
  }

  void updateTodo(String id) {
    _todos.firstWhere((todo) => todo.id == id).copyWith(
          id: id,
          task: _task,
          date: _date.toIso8601String(),
        );
    print('update: $id');
    print('task: $_task');
    print('date: $_date');
    notifyListeners();
  }

  void removeTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    print('delete: $id');
    notifyListeners();
  }
}
