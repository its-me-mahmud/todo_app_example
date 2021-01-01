import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo_model.dart';
import '../providers/todo_provider.dart';
import '../widgets/reusable_button.dart';

class TodoEditPage extends StatefulWidget {
  final TodoModel todoModel;

  const TodoEditPage({this.todoModel});

  @override
  _TodoEditPageState createState() => _TodoEditPageState();
}

class _TodoEditPageState extends State<TodoEditPage> {
  final _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final _todoProvider = Provider.of<TodoProvider>(context, listen: false);
    if (widget.todoModel != null) {
      _taskController.text = widget.todoModel.task;
      // _todoProvider.changeDate = DateTime.parse(widget.todoModel.createdDate);
      _todoProvider.getAllTodo(widget.todoModel);
    } else {
      // _taskController.text = null;
      // _todoProvider.changeDate = DateTime.now();
      _todoProvider.getAllTodo(null);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _taskController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _todoProvider = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todoModel != null ? 'Edit todo' : 'Add todo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              _pickDate(context, _todoProvider).then((value) {
                if (value != null) {
                  _todoProvider.changeDate = value;
                }
              });
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
              onSubmitted: (value) => _todoProvider.changeTask = value,
            ),
            const SizedBox(height: 32),
            ReusableButton(
              color: (widget.todoModel == null) ? Colors.green : Colors.blue,
              title: (widget.todoModel == null) ? 'Save' : 'Update',
              onPressed: () {
                (widget.todoModel == null)
                    ? _todoProvider.addTodo()
                    : _todoProvider.editTodo(
                        widget.todoModel.id, _taskController.text);
                Navigator.pop(context);
              },
            ),
            (widget.todoModel == null)
                ? Container()
                : ReusableButton(
                    color: Theme.of(context).errorColor,
                    title: 'Remove',
                    onPressed: () {
                      _todoProvider.deleteTodo(widget.todoModel.id);
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
    TodoProvider todoProvider,
  ) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: todoProvider.createdDate,
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
