/*
  Created by: Claizel Coubeili Cepe
  Date: 27 October 2022
  Description: Sample todo app with networking
*/

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String userId;
  String? id;
  String title;
  String description;
  bool completed;
  Timestamp deadline;
  String lastEdit;

  Todo({
    required this.userId,
    this.id,
    required this.title,
    required this.completed,
    required this.description,
    required this.deadline,
    required this.lastEdit,
  });

  // Factory constructor to instantiate object from json format
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
      description: json['description'],
      deadline: json['deadline'],
      lastEdit: json['lastEdit']
    );
  }

  static List<Todo> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Todo>((dynamic d) => Todo.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Todo todo) {
    return {
      'userId': todo.userId,
      'title': todo.title,
      'completed': todo.completed,
      'description': todo.description,
      'deadline': todo.deadline,
      'lastEdit': todo.lastEdit
    };
  }
}
