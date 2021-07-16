import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';
import '../utils/routes.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16).copyWith(bottom: 0),
        child: BlocConsumer<TodoBloc, TodoState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is TodoFailure) {
              return Center(
                child: Text(
                  state.error!,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else if (state is TodoSuccess) {
              return (state.todos!.isEmpty || state.todos != null)
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
                      itemCount: state.todos!.length,
                      separatorBuilder: (_, __) => Divider(),
                      itemBuilder: (context, index) {
                        final todo = state.todos![index];
                        print('Todo: { ${todo.task} }');
                        return ListTile(
                          leading: CircleAvatar(child: Text('${index + 1}')),
                          title: Text(todo.task!),
                          subtitle: Text(formatDate(
                            DateTime.parse(todo.createdDate!),
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
            }
            return Container();
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
