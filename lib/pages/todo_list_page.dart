import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_example/models/todo_model.dart';

import '../providers/todo_provider.dart';
import '../utils/routes.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16).copyWith(bottom: 0),
        child: Consumer<TodoProvider>(
          builder: (_, todoProvider, __) {
            return todoProvider.todos.isEmpty
                ? Center(
                    child: const Text(
                      'Empty todos!',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: todoProvider.todos.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      TodoModel todoModel = todoProvider.todos[index];
                      return ListTile(
                        leading: CircleAvatar(child: Text('${index + 1}')),
                        title: Text(todoModel.task),
                        trailing: IconButton(
                          color: Theme.of(context).primaryColor,
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              todoEdit,
                              arguments: todoModel,
                            );
                          },
                        ),
                      );
                    },
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, todoEdit);
        },
      ),
    );
  }
}
