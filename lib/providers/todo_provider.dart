import 'dart:async';

import 'package:flutter/material.dart';

import '../models/todo_model.dart';
import '../services/database_service.dart';

class TodoProvider extends ChangeNotifier {
  DatabaseService _database = DatabaseService.instance;
  String _task;
  DateTime _createdDate;

  get task => _task;
  get createdDate => _createdDate;
  Future<List<TodoModel>> get todos => _database.getTodos();

  set changeTask(String task) {
    _task = task;
    notifyListeners();
  }

  set changeDate(DateTime createdDate) {
    _createdDate = createdDate;
    notifyListeners();
  }

  void getAllTodo(TodoModel todo) {
    if (todo != null) {
      _task = todo.task;
      _createdDate = DateTime.parse(todo.createdDate);
    } else {
      _task = null;
      _createdDate = DateTime.now();
    }
  }

  void addTodo() {
    final newTodo = TodoModel(
      task: _task,
      createdDate: _createdDate.toIso8601String(),
    );
    _database.insertTodo(newTodo);
  }

  // void saveTodo(String task) {
  //   _todos = [
  //     ..._todos,
  //     TodoModel(
  //       id: _uuid.v4(),
  //       task: task.trim(),
  //       date: _date.toIso8601String(),
  //     ),
  //   ];
  //   notifyListeners();
  // }

  void editTodo(int id, String task) {
    // final editedTodo = TodoModel(
    //   task: _task,
    //   createdDate: _createdDate.toIso8601String(),
    // );
  }

  // void updateTodo(String id, String task) {
  //   _todos = [
  //     for (final todoModel in _todos)
  //       if (todoModel.id == id)
  //         TodoModel(
  //           id: todoModel.id,
  //           task: task.trim(),
  //           date: _date.toIso8601String(),
  //         )
  //       else
  //         todoModel,
  //   ];
  //   notifyListeners();
  // }

  void deleteTodo(int id) async {
    notifyListeners();
  }

  // void removeTodo(TodoModel todoModel) {
  //   _todos = _todos.where((todo) => todo.id != todoModel.id).toList();
  //   notifyListeners();
  // }
}
