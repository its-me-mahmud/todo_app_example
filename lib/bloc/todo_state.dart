part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {
  const TodoInitial();
}

class TodoSuccess extends TodoState {
  final List<TodoModel> todos;

  const TodoSuccess({this.todos});

  TodoSuccess copyWith({List<TodoModel> todos}) {
    return TodoSuccess(todos: todos ?? this.todos);
  }

  @override
  List<Object> get props => [todos];
}

class TodoFailure extends TodoState {
  final String error;

  const TodoFailure({this.error});

  @override
  List<Object> get props => [error];
}
