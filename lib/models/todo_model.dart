import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final String id;
  final String task;
  final String date;

  const TodoModel({
    this.id,
    this.task,
    this.date,
  });

  TodoModel copyWith({
    String id,
    String task,
    String date,
  }) {
    return TodoModel(
      id: id ?? this.id,
      task: task ?? this.task,
      date: date ?? this.date,
    );
  }

  @override
  List<Object> get props => [id, task, date];
}
