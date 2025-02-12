/*
* TodoPage()
| Contains the list of todos of the user
| Only the user can add and delete todo
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week7_networking_discussion/models/todo_model.dart';
import 'package:week7_networking_discussion/providers/todo_provider.dart';
import 'package:week7_networking_discussion/screens/modal_todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoPage extends StatefulWidget {
  static const routeName = '/passArguments';
  final String uid;
  final String name;
  TodoPage({super.key, required this.uid, required this.name});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    // access the list of todos in the provider
    Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todos;

    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
      ),
      body: StreamBuilder(
        stream: todosStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text("No Todos Found"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: ((context, index) {
              Todo todo = Todo.fromJson(
                  snapshot.data?.docs[index].data() as Map<String, dynamic>);
              if (todo.userId == widget.uid){
                return Dismissible(
                key: Key(todo.id.toString()),
                onDismissed: (direction) {
                  context.read<TodoListProvider>().changeSelectedTodo(todo);
                  context.read<TodoListProvider>().deleteTodo();

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${todo.title} dismissed')));
                },
                background: Container(
                  color: Colors.red,
                  child: const Icon(Icons.delete),
                ),
                child: ListTile(
                  title: Row(children:[
                    Text(todo.title),
                    SizedBox(width: 20,),
                    Text("${todo.lastEdit}", style: TextStyle(fontSize: 13, color: Colors.grey))
                    ]),
                  leading: Checkbox(
                    value: todo.completed,
                   onChanged: (bool? value) {
                      context.read<TodoListProvider>().changeSelectedTodo(todo);
                      context.read<TodoListProvider>().toggleStatus(value!);
                    },
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          context
                              .read<TodoListProvider>()
                              .changeSelectedTodo(todo);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => TodoModal(
                                  type: 'Edit',
                                  userid: widget.uid.toString(),
                                  name: widget.name.toString(),
                                ),
                              );
                        },
                        icon: const Icon(Icons.create_outlined),
                      ),
                      IconButton(
                        onPressed: () {
                          context
                              .read<TodoListProvider>()
                              .changeSelectedTodo(todo);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => TodoModal(
                              type: 'Delete',
                              userid: widget.uid.toString(),
                              name: widget.name.toString()
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete_outlined),
                      )
                    ],
                  ),
                ),
              );
              }
              return Container();
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                TodoModal(type: 'Add', userid: widget.uid.toString(), name: widget.name.toString(),),
          );
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
