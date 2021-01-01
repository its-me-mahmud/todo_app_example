part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class InsertTodo extends TodoEvent {
  final TodoModel todo;

  const InsertTodo({this.todo});

  InsertTodo copyWith({TodoModel todo}) {
    return InsertTodo(todo: todo ?? this.todo);
  }

  @override
  List<Object> get props => [todo];
}

class FetchTodo extends TodoEvent {
  const FetchTodo();
}

class UpdateTodo extends TodoEvent {
  final int todoIndex;
  final TodoModel newTodo;

  const UpdateTodo({this.todoIndex, this.newTodo});

  UpdateTodo copyWith({int index, TodoModel todo}) {
    return UpdateTodo(
      todoIndex: index ?? this.todoIndex,
      newTodo: todo ?? this.newTodo,
    );
  }

  @override
  List<Object> get props => [todoIndex, newTodo];
}

class DeleteTodo extends TodoEvent {
  final int todoIndex;

  const DeleteTodo({this.todoIndex});

  UpdateTodo copyWith({int index, TodoModel todo}) {
    return UpdateTodo(todoIndex: index ?? this.todoIndex);
  }

  @override
  List<Object> get props => [todoIndex];
}
