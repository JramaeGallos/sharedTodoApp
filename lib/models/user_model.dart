import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  String userid;
  String firstname;
  String lastname;
  String username;
  String email;
  String location;
  Timestamp bday;

  Users({
    required this.userid,
    required this.lastname,
    required this.firstname,
    required this.username,
    required this.email,
    required this.location,
    required this.bday,
  });

  factory Users.fromJson(Map<String, dynamic> json){
    return Users(
      userid: json['userId'],
      lastname: json['lastname'],
      firstname: json['firstname'],
      username: json['username'],
      email: json['email'],
      location: json['location'],
      bday: json['bday']
    );
  }

  Map<String, dynamic> toJson(Users user) {
    return {
      'userId': user.userid,
      'lastname': user.lastname,
      'firstname': user.firstname,
      'username': user.username,
      'email': user.email,
      'location': user.location,
      'bday': user.bday
    };
  }

}