/*
  Created by: Jramae A. Gallos
  Date: December 14, 2022
  Description: Shared Todo App 
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week7_networking_discussion/providers/todo_provider.dart';
import 'package:week7_networking_discussion/providers/auth_provider.dart';
import 'package:week7_networking_discussion/providers/user_provider.dart';
import 'package:week7_networking_discussion/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:week7_networking_discussion/screens/screen_arguments.dart';
import 'package:week7_networking_discussion/screens/todo_page.dart';
import 'firebase_options.dart';
import 'screens/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => TodoListProvider())),
        ChangeNotifierProvider(create: ((context) => UserProvider())),
        ChangeNotifierProvider(create: ((context) => AuthProvider())),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpleTodo',
      initialRoute: '/',
      routes: {'/': (context) => const AuthWrapper()},
      onGenerateRoute: (settings) {
        if (settings.name == TodoPage.routeName) {
          // Cast the arguments to the correct
          // type: ScreenArguments.
          final args = settings.arguments as ScreenArguments;
          return MaterialPageRoute(
            builder: (context) {
              return TodoPage(
                uid: args.uid,
                name: args.name,
              );
            },
          );
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //if authenticated, change to profilepage screen
    if (context.watch<AuthProvider>().isAuthenticated) {
      return const ProfilePage();
    } else {
    //else stay in login page
      return const LoginPage();
    }
  }
}
