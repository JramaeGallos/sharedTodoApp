# Todo App Project

Author: Jramae A. Gallos
Student Number: 202007620
Section: C3L

A Shared Todo Application with friends feature that connects to Firebase Console for persistence of data and authentication of users. A log in page will be rendered when the application started. For users with no existing accounts, they can sign up with their necessary information which will be validated before they can log in.
The profile of the user will be shown once authenticated where he/she can add, edit and delete its list of todos. The user can also interact with other users in the appication by being friends with them. Friends can view and edit the todo of one where details when edited are shwon. They can also disconnect with one another by ufriending and send or accepts request with other users of the application. 

## Folder Structure
```
lib
├───api
│   └───firebase_auth_api.dart
│   └───firebase_todo_api.dart
|   └───firebase_user_api.dart
├───models
│   └───todo_model.dart
|   └───user_model.dart
├───providers
│   └───todo_provider.dart
│   └───auth_provider.dart
|   └───user_provider.dart
├───screens
|   └───screen_argument.dart
│   ├───modal_todo.dart
|   └───friend_todo.dart
│   └───todo_page.dart
|   └───friend_profile.dart
|   └───profile.dart
│   └───login.dart
│   └───signup.dart
└───main.dart
└───firebase_options.dart
```

* Models - contains the data model used
    -> todo_model.dart - class file for todo object
    -> user_model.dart - class file for user object
* Providers - contains the Todo provider that contains the data and method logic
    -> auth_provider.dart - provider file for the authentication of users of the app
    -> user_provider.dart - proider file for the methods used for user collection
    -> todo_provider.dart - provider file for the methods used for todo collection
* Screens - contains the screen/widgets used for users and friends
    -> login.dart - initial page rendered when the application started
    -> signup.dart - users with no existing accounts can sign up and log in
    -> profile.dart - contains the profile of the user
    -> todo_page.dart- contains the list of todos of the user
    -> friend_profile.dart- shows the details of other users to connect with them
    -> friend_todo.dart - shows the list of todos of friends (can only edit)
    -> modal_todo.dart - file that handles logic in form handling
    -> screen_arguments.dart- contains arguments to be passed to other screens for navigation
* API - contains files the connects to the api
    -> firebase_api_auth.dart - connects to api for user authentication
    -> firebase_todo_api.dart - connects to api for todo collection methods
    -> firebase_user_api.dart - connects to api for user collection methods
