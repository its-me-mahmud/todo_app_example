import 'package:flutter_riverpod/all.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_model.dart';

class TodoProvider extends StateNotifier<List<TodoModel>> {
  final _uuid = Uuid();

  TodoProvider(List<TodoModel> initialTodos) : super(initialTodos ?? []);

  // loadTodos(TodoModel todoModel) {
  //   if (todoModel != null) {
  //     _id = todoModel.id;
  //     _task = todoModel.task;
  //     _date = DateTime.parse(todoModel.date);
  //   } else {
  //     _id = null;
  //     _task = null;
  //     _date = DateTime.now();
  //   }
  // }

  void saveTodo(String task, DateTime date) {
    state = [
      ...state,
      TodoModel(
        id: _uuid.v4(),
        task: task,
        date: date.toIso8601String(),
      )
    ];
    print('add: ${_uuid.v4().toString()}');
  }

  void updateTodo(String id, String task) {
    state = [
      for (final todoModel in state)
        if (todoModel.id == id)
          TodoModel(
            id: todoModel.id,
            task: task,
            date: todoModel.date,
          )
        else
          todoModel,
    ];
    print('update: $id');
    print(task);
  }

  void removeTodo(TodoModel todoModel) {
    state = state.where(((todo) => todo.id != todoModel.id)).toList();
    print('delete: ${todoModel.id}');
  }
}
