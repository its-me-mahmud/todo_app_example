import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    if (widget.todoModel != null) {
      _taskController.text = widget.todoModel.task;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _taskController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todoModel != null ? 'Edit todo' : 'Add todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16).copyWith(bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _taskController,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Task',
                hintText: 'Enter your task',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('data'),
                ReusableButton(
                  color: Theme.of(context).primaryColor,
                  title: 'Choose Date',
                  onPressed: () => chooseDate(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ReusableButton(
              color: (widget.todoModel == null) ? Colors.green : Colors.blue,
              title: (widget.todoModel == null) ? 'Save' : 'Update',
              onPressed: () {
                (widget.todoModel == null)
                    ? context.read(todoProvider).saveTodo(_taskController.text)
                    : context
                        .read(todoProvider)
                        .updateTodo(widget.todoModel.id, _taskController.text);
                Navigator.pop(context);
              },
            ),
            (widget.todoModel == null)
                ? Container()
                : ReusableButton(
                    color: Theme.of(context).errorColor,
                    title: 'Remove',
                    onPressed: () {
                      context.read(todoProvider).removeTodo(widget.todoModel);
                      Navigator.pop(context);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Future<DateTime> chooseDate(BuildContext context) async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    return date;
  }
}
