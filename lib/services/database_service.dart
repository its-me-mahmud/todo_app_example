import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo_model.dart';

class DatabaseService {
  static const TABLE_NAME = 'todos';
  static const COLUMN_ID = 'id';
  static const COLUMN_TASK = 'task';
  static const COLUMN_CREATED_DATE = 'created_date';

  DatabaseService._();
  static final instance = DatabaseService._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _createDatabase();
    return _database;
  }

  Future<Database> _createDatabase() async {
    final docDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(docDirectory.path, 'todo_db.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  FutureOr<void> _onCreate(Database database, int version) async {
    await database.execute(
      '''CREATE TABLE $TABLE_NAME(
          $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
          $COLUMN_TASK TEXT,
          $COLUMN_CREATED_DATE TEXT
          )''',
    );
  }

  Future<List<TodoModel>> getTodos() async {
    final db = await database;
    var todos = await db.query(
      TABLE_NAME,
      columns: [COLUMN_ID, COLUMN_TASK, COLUMN_CREATED_DATE],
    );
    List<TodoModel> todoList = [];
    todos.forEach((currentTodo) {
      TodoModel todo = TodoModel.fromMap(currentTodo);
      todoList.add(todo);
    });
    return todoList;
  }

  Future<TodoModel> insertTodo({TodoModel todo}) async {
    final db = await database;
    todo.id = await db.insert(TABLE_NAME, todo.toMap());
    return todo;
  }
}
