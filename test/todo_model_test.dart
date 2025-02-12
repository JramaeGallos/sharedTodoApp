import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:week7_networking_discussion/models/todo_model.dart';


void main() {
  group("Todo Model", () {
    test('Test Todo Model constructor', () {
      final modelInstance = Todo(userId: "userid", id: "todoid", title: "Test Todo", 
      description: "Project", completed: false, deadline: Timestamp(123456, 1233456), lastEdit: "jara - 12/13/2022");
      expect(modelInstance.userId, "userid");
      expect(modelInstance.id, "todoid");
      expect(modelInstance.title, "Test Todo");
      expect(modelInstance.description, "Project");
      expect(modelInstance.completed, false);
      expect(modelInstance.deadline, Timestamp(123456, 1233456));
      expect(modelInstance.lastEdit, "jara - 12/13/2022");
    });

    test('Test Todo Model toJson method', () {
      final modelInstance = Todo(userId: "userid", title: "Test Todo", completed: false,
      description: "Project", deadline: Timestamp(123456, 1233456), lastEdit: "jara - 12/13/2022");

      // do something
      final converted = modelInstance.toJson(modelInstance);

      //test the actual vs the expected
      expect(
          converted, {"userId": "userid", "title":"Test Todo", "completed": false, "description": "Project",
          "deadline": Timestamp(123456, 1233456), "lastEdit": "jara - 12/13/2022" });
    });
  });
}
