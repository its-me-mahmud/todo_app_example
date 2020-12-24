import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_example/providers/todo_provider.dart';

import '../models/todo_model.dart';
import '../utils/routes.dart';


final   todoProvider = StateNotifierProvider<TodoProvider>((ref) {
    return TodoProvider( [ TodoModel(id:'1',task: 'debug code',date: DateTime.now().toString(),),]);
});

class TodoListPage extends StatelessWidget {
final todos= watch(todoProvider.state);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16).copyWith(bottom: 0),
        child:  todoProvider.todos.isEmpty
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
