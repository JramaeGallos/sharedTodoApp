/*
* FirebaseUserAPI()
| Connects to the firebase for user collection
*/

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  late DocumentSnapshot documentSnapshot;

  Future<DocumentSnapshot> getUser(String id) async {
    await db
        .collection("users")
        .doc(id)
        .get()
        .then((value) => documentSnapshot = value);

    return documentSnapshot;
  }

  Stream<QuerySnapshot> getAllUsers() {
    return db.collection("users").snapshots();
  }

  Future<String> AcceptFriend(String id, dynamic element) async {
    var val = [];
    val.add(element);
    var val2 = [];
    val2.add(id);
    try {
      await db.collection("users").doc(id).update({
        'friends': FieldValue.arrayUnion(val),
      });
      await db.collection("users").doc(id).update({
        'recFriendReq': FieldValue.arrayRemove(val),
      });
      await db.collection("users").doc(element).update({
        'sentFriendReq': FieldValue.arrayRemove(val2),
      });
      return "Successfully added friend to the friends list!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> rejectFriend(String id, dynamic element) async {
    var val = [];
    val.add(element);
    var val2 = [];
    val2.add(id);
    try {
      await db.collection("users").doc(id).update({
        'recFriendReq': FieldValue.arrayRemove(val),
      });
      await db.collection("users").doc(element).update({
        'sentFriendReq': FieldValue.arrayRemove(val2),
      });
      return "Successfully deleted friend from friend request!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> Unfriend(String id, dynamic element) async {
    var val = [];
    val.add(element);
    try {
      await db.collection("users").doc(id).update({
        'friends': FieldValue.arrayRemove(val),
      });
      return "Successfully deleted friend from friends list!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> AddFriend(String id, dynamic element) async {
    var val = [];
    val.add(element);
    var val2 = [];
    val2.add(id);
    try {
      await db.collection("users").doc(id).update({
        'sentFriendReq': FieldValue.arrayUnion(val),
      });
      await db.collection("users").doc(element).update({
        'recFriendReq': FieldValue.arrayUnion(val2),
      });
      return "Successfully added friend to the friends list!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> cancelRequest(String id, dynamic element) async {
    var val = [];
    val.add(element);
    try {
      await db.collection("users").doc(id).update({
        'sentFriendReq': FieldValue.arrayRemove(val),
      });
      return "Successfully deleted friend from friends list!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
