import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_example/models/todo_model.dart';
import 'package:todo_app_example/services/database_service.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final DatabaseService _databaseService;

  TodoBloc({DatabaseService databaseService})
      : _databaseService = databaseService,
        super(TodoInitial());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is InsertTodo) {
      await _databaseService.insertTodo(todo: event.todo);
    } else if (event is FetchTodo) {
      final todos = await _databaseService.getTodos();
      yield TodoSuccess(todos: todos);
    }
  }
}
