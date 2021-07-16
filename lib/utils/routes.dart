import 'package:flutter/material.dart';
import 'package:todo_app_example/models/todo_model.dart';

import '../pages/edit_page.dart';
import '../pages/home_page.dart';

const todoList = '/';
const todoEdit = '/todo-add';

final routes = {
  todoList: (context) => HomePage(),
  todoEdit: (context) => EditPage(
        todoModel: ModalRoute.of(context)!.settings.arguments as TodoModel?,
      ),
};
