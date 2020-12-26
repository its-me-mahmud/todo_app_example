import 'package:flutter/material.dart';

import '../pages/todo_edit_page.dart';
import '../pages/todo_list_page.dart';

const todoList = '/';
const todoEdit = '/todo-add';

final routes = {
  todoList: (context) => TodoListPage(),
  todoEdit: (context) => TodoEditPage(
        todoModel: ModalRoute.of(context).settings.arguments,
      ),
};
