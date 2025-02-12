/*
* TodoModal()
| Handles the methods in handling user's todo
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week7_networking_discussion/models/todo_model.dart';
import 'package:week7_networking_discussion/providers/todo_provider.dart';
import 'package:date_field/date_field.dart';

class TodoModal extends StatelessWidget {
  String type;
  String userid;
  String name;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late Timestamp deadline;
  final _formKey = GlobalKey<FormState>();

  TodoModal({
    super.key,
    required this.type,
    required this.userid,
    required this.name,
  });

  // Method to show the title of the modal depending on the functionality
  Text _buildTitle() {
    switch (type) {
      case 'Add':
        return const Text("Add new todo");
      case 'Edit':
        return const Text("Edit todo");
      case 'Delete':
        return const Text("Delete todo");
      default:
        return const Text("");
    }
  }

  // Method to build the content or body depending on the functionality
  Widget _buildContent(BuildContext context) {
    // Use context.read to get the last updated list of todos
    // List<Todo> todoItems = context.read<TodoListProvider>().todo;

    switch (type) {
      case 'Delete':
        {
          return Text(
            "Are you sure you want to delete '${context.read<TodoListProvider>().selected.title}?",
          );
        }
      // Edit and add will have input field in them
      default:
        return Form(
          key: _formKey,
          child: 
          Container(
          height: 200,
          width: 50,
          child: ListView(
            shrinkWrap: true,
            children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Enter Title",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Empty Field';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Enter Description",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Empty Field';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            DateTimeFormField(
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'Schedule Deadline',
                ),
                mode: DateTimeFieldPickerMode.dateAndTime,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onDateSelected: (DateTime value) {
                  deadline= Timestamp.fromDate(value);
                },
                validator: (value) {
                var now = DateTime.now();
                if (value == null) {
                  return 'Empty Field';
                }
                else if (value.compareTo(now) < 0) {
                  return 'Invalid Schedule Date';
                }
                return null;
              },
              )
          ],)
        )
        );
    }
  }

  TextButton _dialogAction(BuildContext context) {
    // List<Todo> todoItems = context.read<TodoListProvider>().todo;

    return TextButton(
      onPressed: () {
        switch (type) {
          case 'Add':
            {
               if (_formKey.currentState!.validate()) {
                // Instantiate a todo objeect to be inserted, default userID will be 1, the id will be the next id in the list
                Todo temp = Todo(
                    userId: userid,
                    completed: false,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    deadline: deadline,
                    lastEdit: ""
                    );

                context.read<TodoListProvider>().addTodo(temp);

                // Remove dialog after adding
                Navigator.of(context).pop();
               }
              break;
            }
          case 'Edit':
            {
              int ts = DateTime.now().millisecondsSinceEpoch;
              DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(ts);
              String datetime = tsdate.year.toString() + "/" + tsdate.month.toString() + "/" + tsdate.day.toString() + " (" +tsdate.hour.toString() + ":" + tsdate.minute.toString() + ")";
              if (_formKey.currentState!.validate()) {
                context
                  .read<TodoListProvider>()
                  .editTodo(_titleController.text, _descriptionController.text, deadline, "last edited: ${name} - ${datetime}");
                   // Remove dialog after editing
                  Navigator.of(context).pop();
              }
              break;
            }
          case 'Delete':
            {
              context.read<TodoListProvider>().deleteTodo();

              // Remove dialog after editing
              Navigator.of(context).pop();
              break;
            }
        }
      },
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.labelLarge,
      ),
      child: Text(type),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _buildTitle(),
      content: _buildContent(context),

      // Contains two buttons - add/edit/delete, and cancel
      actions: <Widget>[
        _dialogAction(context),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}
