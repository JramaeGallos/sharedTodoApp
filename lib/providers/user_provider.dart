/*
* UserProvider
| Provider file for user collection
*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../api/firebase_user_api.dart';

class UserProvider with ChangeNotifier {
  late FirebaseUserAPI firebaseService;
  late Stream<QuerySnapshot> _userStream;

  UserProvider() {
    firebaseService = FirebaseUserAPI();
    fetchUsers();
  }

  Stream<QuerySnapshot> get users => _userStream;

  Future<DocumentSnapshot<dynamic>> getusername(String id) async {
    return await firebaseService.getUser(id);
  }

  void fetchUsers() {
    _userStream = firebaseService.getAllUsers();
    notifyListeners();
  }

  void AcceptFriend(String id, dynamic element) async {
    String message = await firebaseService.AcceptFriend(id, element);
    print(message);
    notifyListeners();
  }

  void rejectFriend(String id, dynamic element) async {
    String message = await firebaseService.rejectFriend(id, element);
    print(message);
    notifyListeners();
  }

  void unfriend(String id, dynamic element) async {
    String message = await firebaseService.Unfriend(id, element);
    print(message);
    notifyListeners();
  }

  void addFriend(String id, dynamic element) async {
    String message = await firebaseService.AddFriend(id, element);
    print(message);
    notifyListeners();
  }

  void cancelRequest(String id, dynamic element) async {
    String message = await firebaseService.cancelRequest(id, element);
    print(message);
    notifyListeners();
  }
}
