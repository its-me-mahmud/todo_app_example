import '../services/database_service.dart';

class TodoModel {
  int id;
  String task;
  String createdDate;

  TodoModel({
    this.id,
    this.task,
    this.createdDate,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      DatabaseService.COLUMN_TASK: task,
      DatabaseService.COLUMN_CREATED_DATE: createdDate,
    };
    if (id != null) {
      map[DatabaseService.COLUMN_ID] = id;
    }
    return map;
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map[DatabaseService.COLUMN_ID],
      task: map[DatabaseService.COLUMN_TASK],
      createdDate: map[DatabaseService.COLUMN_CREATED_DATE],
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TodoModel &&
        o.id == id &&
        o.task == task &&
        o.createdDate == createdDate;
  }

  @override
  int get hashCode => id.hashCode ^ task.hashCode ^ createdDate.hashCode;
}
