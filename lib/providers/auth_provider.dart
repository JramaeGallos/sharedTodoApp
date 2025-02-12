/*
* AuthProvider()
| Provider file for user authentication
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:week7_networking_discussion/api/firebase_api_auth.dart';

class AuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  User? userObj;

  AuthProvider() {
    authService = FirebaseAuthAPI();
    authService.getUser().listen((User? newUser) {
      userObj = newUser;
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $newUser');
      notifyListeners();
    }, onError: (e) {
      // provide a more useful error
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $e');
    });
  }

  User? get user => userObj;

  bool get isAuthenticated {
    return user != null;
  }

  signIn(String email, String password){
     authService.signIn(email, password);
  }

  void signOut() {
    authService.signOut();
  }

  signUp(
      String email,
      String password,
      String firstname,
      String lastname,
      String username,
      String location,
      Timestamp bday,
      List<String> friends,
      List<String> recFriendReq,
      List<String> sentFriendReq){
      authService.signUp(email, password, firstname, lastname, username, location,
        bday, friends, recFriendReq, sentFriendReq);
  }
}
