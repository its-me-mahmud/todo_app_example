import 'package:flutter_riverpod/all.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_model.dart';

final todoProvider = StateNotifierProvider<TodoProvider>((ref) {
  return TodoProvider(initialTodos: []);
});

class TodoProvider extends StateNotifier<List<TodoModel>> {
  final _uuid = Uuid();
  DateTime _date = DateTime.now();

  TodoProvider({List<TodoModel> initialTodos}) : super(initialTodos ?? []);

  get date => _date;

  set changeDate(DateTime date) {
    _date = date;
  }

  void saveTodo(String task) {
    state = [
      ...state,
      TodoModel(
        id: _uuid.v4(),
        task: task,
        date: _date.toIso8601String(),
      )
    ];
  }

  void updateTodo(String id, String task) {
    state = [
      for (final todoModel in state)
        if (todoModel.id == id)
          TodoModel(
            id: todoModel.id,
            task: task,
            date: _date.toIso8601String(),
          )
        else
          todoModel,
    ];
  }

  void removeTodo(TodoModel todoModel) {
    state = state.where(((todo) => todo.id != todoModel.id)).toList();
  }
}
