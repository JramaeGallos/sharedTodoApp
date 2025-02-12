/*
* LoginPage()
| Lets the user log in by providing their email and password information
| Inputs from the user are validated
| Once the user is authenticated, change to Profile Page Screen
 */

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week7_networking_discussion/providers/auth_provider.dart';
import 'package:week7_networking_discussion/screens/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    //contains email and password textformfield
    //and login and signup button
    final login_form= Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        children: [
          TextFormField(
            key: const Key('emailField'),
            controller: emailController,
            decoration: const InputDecoration(
              hintText: "Email",
            ),
            validator: (value) {
              bool isValid = EmailValidator.validate(emailController.text);
              if (value == null || value.isEmpty) {
                return "Please enter your email";
              } else if (isValid == false) {
                return "Invalid Email";
              }
              return null;
            }
          ),
          TextFormField(
            key: const Key('pwField'),
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
            validator: (value) {
                RegExp dmatch = RegExp(r"[\d]{1,}");
                RegExp lmatch = RegExp(r"[a-z]{1,}");
                RegExp umatch = RegExp(r"[A-Z]{1,}");
                RegExp smatch = RegExp(r"[^A-Za-z0-9]{1,}");
                if (value == null || value.isEmpty) {
                  return "Please enter your password";
                } else if (value.length <= 8 ||
                    dmatch.hasMatch(value) == false ||
                    lmatch.hasMatch(value) == false ||
                    umatch.hasMatch(value) == false ||
                    smatch.hasMatch(value) == false) {
                  return 'Invalid Password';
                }
                return null;
              },
          ),
          Padding(
            key: const Key('loginButton'),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context
                  .read<AuthProvider>()
                  .signIn(emailController.text, passwordController.text);
                }
              },
              child: const Text('Log In', style: TextStyle(color: Colors.white)),
            ),
          ),
          Padding(
            key: const Key('signUpButton'),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SignupPage(),
                  ),
                );
              },
              child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
            ),
          )

        ],)
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          children: <Widget>[
            const Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            login_form
          ],
        ),
      ),
    );
  }
}
