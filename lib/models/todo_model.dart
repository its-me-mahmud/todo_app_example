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

  @override
  List<Object> get props => [id, task, date];
}
