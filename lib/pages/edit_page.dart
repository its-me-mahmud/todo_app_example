import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/todo_bloc.dart';
import '../models/todo_model.dart';
import '../widgets/reusable_button.dart';

class EditPage extends StatefulWidget {
  final TodoModel todoModel;

  const EditPage({this.todoModel});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TodoBloc _todoBloc;
  final _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _todoBloc = context.read<TodoBloc>();
    if (widget.todoModel != null) {
      _taskController.text = widget.todoModel.task;
      // _todoProvider.changeDate = DateTime.parse(widget.todoModel.createdDate);
      _todoBloc.add(FetchTodo());
    } else {
      // _taskController.text = null;
      // _todoProvider.changeDate = DateTime.now();
      // _todoBloc.add(FetchTodo());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _todoBloc.close();
    _taskController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todoModel != null ? 'Edit todo' : 'Add todo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              // _pickDate(context, _todoBloc).then((value) {
              //   if (value != null) {
              //     _todoBloc.changeDate = value;
              //   }
              // });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16).copyWith(bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              autofocus: true,
              controller: _taskController,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Task',
                hintText: 'Enter your task',
              ),
              onSubmitted: (value) =>
                  _todoBloc.add(InsertTodo(todo: widget.todoModel)),
            ),
            const SizedBox(height: 32),
            ReusableButton(
              color: (widget.todoModel == null) ? Colors.green : Colors.blue,
              title: (widget.todoModel == null) ? 'Save' : 'Update',
              onPressed: () {
                (widget.todoModel == null)
                    ? _todoBloc.add(InsertTodo(todo: widget.todoModel))
                    : _todoBloc.add(UpdateTodo(
                        todoIndex: widget.todoModel.id,
                        newTodo: widget.todoModel,
                      ));
                Navigator.pop(context);
              },
            ),
            (widget.todoModel == null)
                ? Container()
                : ReusableButton(
                    color: Theme.of(context).errorColor,
                    title: 'Remove',
                    onPressed: () {
                      _todoBloc.add(DeleteTodo(todoIndex: widget.todoModel.id));
                      Navigator.pop(context);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Future<DateTime> _pickDate(
    BuildContext context,
    TodoBloc todoBloc,
  ) async {
    final pickedDate = await showDatePicker(
      context: context,
      // initialDate: todoBloc.createdDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null) {
      return pickedDate;
    } else {
      return null;
    }
  }
}
