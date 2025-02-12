import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:week7_networking_discussion/models/todo_model.dart';
import 'package:week7_networking_discussion/models/user_model.dart';


void main() {
  group("User Model", () {
    test('Test Todo Model constructor', () {
      final modelInstance = Users(userid: "abcde", firstname: "jramae", lastname: "gallos", username: "jara",
      email: "jara@gmail.com", location: "albay", bday: Timestamp(123456, 123456));
      expect(modelInstance.userid, "abcde");
      expect(modelInstance.firstname, "jramae");
      expect(modelInstance.lastname, "gallos");
      expect(modelInstance.username, "jara");
      expect(modelInstance.email, "jara@gmail.com");
      expect(modelInstance.location, "albay");
      expect(modelInstance.bday, Timestamp(123456, 123456));
    });

    test('Test Todo Model toJson method', () {
      final modelInstance = Users(userid: "abcde", lastname: "gallos",  firstname: "jramae", username: "jara",
      email: "jara@gmail.com", location: "albay", bday: Timestamp(123456, 123456));

      // do something
      final converted = modelInstance.toJson(modelInstance);

      //test the actual vs the expected
      expect(
          converted, {"userId":"abcde", "lastname": "gallos", "firstname":"jramae", "username":"jara",
           "email":"jara@gmail.com", "location":"albay", "bday": Timestamp(123456, 123456)});
    });
  });
}
