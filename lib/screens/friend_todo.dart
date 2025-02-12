/*
* FriendTodoPage()
| Shows the list of todos of friend user
| User can only edit the todo of friends
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week7_networking_discussion/models/todo_model.dart';
import '../providers/todo_provider.dart';
import 'modal_todo.dart';

class FriendTodoPage extends StatefulWidget {
  final String uid;
  final String username;
  FriendTodoPage({super.key, required this.uid, required this.username});

  @override
  State<FriendTodoPage> createState() => _FriendTodoPageState();
}

class _FriendTodoPageState extends State<FriendTodoPage> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todos;

    return Scaffold(
      appBar: AppBar(
        title:Text("Todo")),
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
                 return ListTile(
                  title: Row(children:[
                    Text(todo.title),
                    SizedBox(width: 20,),
                    Text("${todo.lastEdit}", style: TextStyle(fontSize: 13, color: Colors.grey))
                    ]),
                  trailing: 
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
                                  name: widget.username.toString(),
                                ),
                              );
                        },
                        icon: const Icon(Icons.create_outlined),
                      ),
                );
              }
              return Container();
            })
           );
        }
      )

    );
  }
}