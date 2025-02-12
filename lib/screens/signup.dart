/*
* SignupPage()
| Lets the user create their account by signing up with their required information
| Inputs from the user are validated
| Once the user is authenticated, change to Profile Page Screen
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week7_networking_discussion/providers/auth_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:date_field/date_field.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  late Timestamp bday;
  late List<String> friends = [];
  late List<String> recFriendReq = [];
  late List<String> sentFriendReq = [];

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController firstnameController = TextEditingController();
    TextEditingController lastnameController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController locationController = TextEditingController();

    //contains form field widgets where users will input their information
    final signup_form = Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          children: [
            TextFormField(
              controller: firstnameController,
              decoration: const InputDecoration(
                hintText: 'Fist Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: lastnameController,
              decoration: const InputDecoration(
                hintText: 'Last Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: 'User Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            DateTimeFormField(
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.black45),
                errorStyle: TextStyle(color: Colors.redAccent),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.event_note),
                labelText: 'Birthdate',
              ),
              mode: DateTimeFieldPickerMode.date,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onDateSelected: (DateTime value) {
                bday= Timestamp.fromDate(value);
              },
              validator: (value) {
                var now = DateTime.now();
                if (value == null) {
                  return 'Please enter your birthdate';
                } else if (value.compareTo(now) > 0) {
                  return 'Invalid Birthdate';
                }
                return null;
              },
            ),
            TextFormField(
              controller: locationController,
              decoration: const InputDecoration(
                hintText: 'Current Address',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your current address';
                }
                return null;
              },
            ),
            TextFormField(
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
                }),
            TextFormField(
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
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()){
                    context.read<AuthProvider>().signUp(
                        emailController.text,
                        passwordController.text,
                        firstnameController.text,
                        lastnameController.text,
                        usernameController.text,
                        locationController.text,
                        bday,
                        friends,
                        recFriendReq,
                        sentFriendReq);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Sign up',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child:
                    const Text('Back', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          children: <Widget>[
            const Text(
              "Sign Up",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            signup_form
          ],
        ),
      ),
    );
  }
}
