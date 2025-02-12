/*
* FirebaseAuthAPI()
| Connects to the firebase for user authentication
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  // Allow read/write access on all documents to any user signed in to the application

  Stream<User?> getUser() {
    return auth.authStateChanges();
  }

void signIn(String email, String password) async {
    UserCredential credential;
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //possible to return something more useful
        //than just print an error message to improve UI/UX
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
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
      List<String> sentFriendReq) async {
    UserCredential credential;
    try {
      credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        saveUserToFirestore(credential.user?.uid, email, firstname, lastname,
            username, location, bday, friends, recFriendReq, sentFriendReq);
      }
    } on FirebaseAuthException catch (e) {
      //possible to return something more useful
      //than just print an error message to improve UI/UX
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void signOut() async {
    auth.signOut();
  }

  void saveUserToFirestore(
      String? uid,
      String email,
      String firstname,
      String lastname,
      String username,
      String location,
      Timestamp bday,
      List<String> friends,
      List<String> recFriendReq,
      List<String> sentFriendReq) async {
    try {
      await db.collection("users").doc(uid).set({
        "email": email,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "location": location,
        "bday": bday,
        "friends": friends,
        "recFriendReq": recFriendReq,
        "sentFriendReq": sentFriendReq
      });
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
