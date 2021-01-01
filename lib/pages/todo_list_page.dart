import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo_model.dart';
import '../providers/todo_provider.dart';
import '../utils/routes.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16).copyWith(bottom: 0),
        child: FutureBuilder<List<TodoModel>>(
          future: _todoProvider.todos,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: const Text(
                  'Something went wrong!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return (snapshot.data.isEmpty || snapshot.data != null)
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
                    itemCount: snapshot.data.length,
                    separatorBuilder: (_, __) => Divider(),
                    itemBuilder: (context, index) {
                      final todo = snapshot.data[index];
                      print('Todo: { ${todo.task} }');
                      return ListTile(
                        leading: CircleAvatar(child: Text('${index + 1}')),
                        title: Text(todo.task),
                        subtitle: Text(formatDate(
                          DateTime.parse(todo.createdDate),
                          [dd, '-', mm, '-', yyyy],
                        )),
                        trailing: IconButton(
                          color: Theme.of(context).primaryColor,
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              todoEdit,
                              arguments: todo,
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
