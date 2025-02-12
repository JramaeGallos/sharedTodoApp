/*
* FriendProfilePage()
| Shows the details of a friend
| Shows the list of todos where the user can edit
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week7_networking_discussion/screens/friend_todo.dart';

import '../providers/user_provider.dart';

class FriendProfilePage extends StatefulWidget {
  final String? id;
  final String type;
  final String currentUserId;
  final String username;
  const FriendProfilePage(
      {super.key,
      required this.id,
      required this.type,
      required this.currentUserId,
      required this.username});

  @override
  State<FriendProfilePage> createState() => _FriendProfilePageState();
}

class _FriendProfilePageState extends State<FriendProfilePage> {
  late String name;
  Widget buildStatus() {
    switch (widget.type) {
      case "friend":
        return ListView(
          shrinkWrap: true,
          children: [
            Card(
              child: OutlinedButton(
                onPressed: () {
                  context
                      .read<UserProvider>()
                      .unfriend(widget.currentUserId, widget.id!);
                  context
                      .read<UserProvider>()
                      .unfriend(widget.id!, widget.currentUserId);
                  Navigator.of(context).pop();
                },
                child: Text("Unfriend",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.green,
                ),
              ),
            ),
            Card(
              child: OutlinedButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FriendTodoPage(
                              uid: widget.id!,
                              username: widget.username,
                            )),
                  );
                },
                child: Text("Todo",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.green,
                ),
              ),
            )
          ],
        );
      case "recFriendReq":
        return Card(
            child: Column(
          children: [
            Card(
              child: OutlinedButton(
                onPressed: () {
                  context
                      .read<UserProvider>()
                      .AcceptFriend(widget.currentUserId, widget.id!);
                  Navigator.of(context).pop();
                },
                child: Text("Accept",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.green,
                ),
              ),
            ),
            Card(
              child: OutlinedButton(
                onPressed: () {
                  context
                      .read<UserProvider>()
                      .rejectFriend(widget.currentUserId, widget.id!);
                  Navigator.of(context).pop();
                },
                child: Text("Reject",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ],
        ));
      case "sentFriendReq":
        return Card(
          child: OutlinedButton(
            onPressed: () {
              context
                  .read<UserProvider>()
                  .cancelRequest(widget.currentUserId, widget.id!);
              Navigator.of(context).pop();
            },
            child: Text("Cancel Request",
                style: TextStyle(fontSize: 20, color: Colors.white)),
            style: OutlinedButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.green,
            ),
          ),
        );
      case "not_friend":
        return Card(
          child: OutlinedButton(
            onPressed: () {
              context
                  .read<UserProvider>()
                  .addFriend(widget.currentUserId, widget.id!);
              Navigator.of(context).pop();
            },
            child: Text("Add Friend",
                style: TextStyle(fontSize: 20, color: Colors.white)),
            style: OutlinedButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.green,
            ),
          ),
        );
      default:
        return Text("");
    }
  }

  Widget build(BuildContext context) {
    Future<DocumentSnapshot<Object?>> username =
        context.watch<UserProvider>().getusername(widget.id!);
    return Scaffold(
        appBar: AppBar(title: Text("People")),
        body: FutureBuilder(
            future: username,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error encountered! ${snapshot.error}"),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData) {
                return Center(
                  child: Text("No User Found"),
                );
              }
              name= snapshot.data!["username"];
              int ts = snapshot.data!["bday"].millisecondsSinceEpoch;
              DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(ts);
              String bday = tsdate.month.toString() + "/" + tsdate.day.toString() + "/" + tsdate.year.toString();
              return ListView(children: [
                Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.green, Colors.greenAccent])),
                    child: Container(
                      width: double.infinity,
                      height: 350.0,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://static.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg",
                              ),
                              radius: 50.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "reaching for the stars",
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5.0),
                              clipBehavior: Clip.antiAlias,
                              color: Colors.white,
                              elevation: 5.0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 22.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.cake,
                                            color: Colors.green,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            bday,
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.green,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            color: Colors.green,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "${snapshot.data!["firstname"]} ${snapshot.data!["lastname"]}",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 2.0,
                                          ),
                                          Text(
                                            widget.id!,
                                            style: TextStyle(
                                              fontSize: 10.0,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.green,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            snapshot.data!["location"],
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.green,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  height: 10.0,
                ),
                buildStatus(),
              ]);
            }));
  }
}
