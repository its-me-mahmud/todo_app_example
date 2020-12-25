import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  var _uuid = Uuid();
  List<TodoModel> _todos = [];

  get todos => _todos;

  void saveTodo(String task) {
    _todos = [
      ..._todos,
      TodoModel(
        id: _uuid.v4(),
        task: task,
        date: DateTime.now().toString(),
      ),
    ];
    print('add id: ${_uuid.v4().toString()}');
    notifyListeners();
  }

  void updateTodo(String id, String task) {
    _todos = [
      for (final todoModel in _todos)
        if (todoModel.id == id)
          TodoModel(
            id: todoModel.id,
            task: task,
            date: DateTime.now().toString(),
          )
        else
          todoModel,
    ];
    print('update id: $id');
    print('task: $task');
    notifyListeners();
  }

  void removeTodo(TodoModel todoModel) {
    _todos = _todos.where((todo) => todo.id != todoModel.id).toList();
    print('delete id: ${todoModel.id}');
    notifyListeners();
  }
}
