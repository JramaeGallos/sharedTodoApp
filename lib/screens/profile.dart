/*
* ProfilePage()
| Initial page rendered once user is autheticated
| Shows information about the user as well the list of friends and friend requests
| Can navigate to the Todolist Page that contains the list of todos of the user
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week7_networking_discussion/providers/auth_provider.dart';
import 'package:week7_networking_discussion/providers/user_provider.dart';
import 'package:week7_networking_discussion/screens/friend_profile.dart';
import 'package:week7_networking_discussion/screens/screen_arguments.dart';
import 'package:week7_networking_discussion/screens/todo_page.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String search = "";
  late List<dynamic> friends;
  late List<dynamic> recFriendReq;
  late List<dynamic> sentFriendReq;

  @override
  Widget build(BuildContext context) {
    var userid = context.watch<AuthProvider>().user;
    String? uid = userid?.uid;
    String? name;
    String bday;
    Future<DocumentSnapshot<Object?>> username =
        context.watch<UserProvider>().getusername(uid!);
    Stream<QuerySnapshot>? usersStream = context.watch<UserProvider>().users;

    return Scaffold(
      //renders the list of users and implement the search method
        drawer: Drawer(
            child:
                ListView(shrinkWrap: true, padding: EdgeInsets.zero, children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text('Connect with People',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                }),
          ),
          StreamBuilder(
              stream: usersStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error encountered! ${snapshot.error}"),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Text("No Users Found"),
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      var user = snapshot.data?.docs[index].data()
                          as Map<String, dynamic>;
                      if (search.isEmpty) {
                        return Container(
                            margin: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                            child: Row(children: [
                              Icon(Icons.person),
                              TextButton(
                                  onPressed: () {
                                    String type= "";
                                    if (snapshot.data?.docs[index].id == uid) {
                                      Navigator.pop(context);
                                    } else if (checkType(friends,
                                            snapshot.data?.docs[index].id) ==
                                        true) {
                                      type = "friend";
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FriendProfilePage(
                                                  id: snapshot
                                                      .data?.docs[index].id,
                                                  type: type,
                                                  currentUserId: uid,
                                                  username: name!,
                                                )),
                                      );
                                    } else if (checkType(recFriendReq,
                                            snapshot.data?.docs[index].id) ==
                                        true) {
                                      type = "recFriendReq";
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FriendProfilePage(
                                                  id: snapshot
                                                      .data?.docs[index].id,
                                                  type: type,
                                                  currentUserId: uid,
                                                  username: name!,
                                                )),
                                      );
                                    } else if (checkType(sentFriendReq,
                                            snapshot.data?.docs[index].id) ==
                                        true) {
                                      type = "sentFriendReq";
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FriendProfilePage(
                                                  id: snapshot
                                                      .data?.docs[index].id,
                                                  type: type,
                                                  currentUserId: uid,
                                                  username: name!,
                                                )),
                                      );
                                    } else {
                                      type = "not_friend";
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FriendProfilePage(
                                                  id: snapshot
                                                      .data?.docs[index].id,
                                                  type: type,
                                                  currentUserId: uid,
                                                  username: name!,
                                        )),
                                      );
                                    }
                                  },
                                  child: Text(
                                      "${user["firstname"]} ${user["lastname"]}",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black)))
                            ]));
                      }
                      if (user["firstname"]
                          .toString()
                          .toLowerCase()
                          .startsWith(search.toLowerCase())) {
                        return Container(
                            margin: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                            child: Row(children: [
                              Icon(Icons.person),
                              TextButton(
                                  onPressed: () {
                                    String type = "";
                                    if (snapshot.data?.docs[index].id == uid) {
                                      Navigator.pop(context);
                                    } else if (checkType(friends,
                                            snapshot.data?.docs[index].id) ==
                                        true) {
                                      type = "friend";
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FriendProfilePage(
                                                  id: snapshot
                                                      .data?.docs[index].id,
                                                  type: type,
                                                  currentUserId: uid,
                                                  username: name!,
                                                )),
                                      );
                                    } else if (checkType(recFriendReq,
                                            snapshot.data?.docs[index].id) ==
                                        true) {
                                      type = "recFriendReq";
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FriendProfilePage(
                                                  id: snapshot
                                                      .data?.docs[index].id,
                                                  type: type,
                                                  currentUserId: uid,
                                                  username: name!,
                                                )),
                                      );
                                    } else if (checkType(sentFriendReq,
                                            snapshot.data?.docs[index].id) ==
                                        true) {
                                      type = "sentFriendReq";
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FriendProfilePage(
                                                  id: snapshot
                                                      .data?.docs[index].id,
                                                  type: type,
                                                  currentUserId: uid,
                                                  username: name!,
                                                )),
                                      );
                                    } else {
                                      type = "not_friend";
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FriendProfilePage(
                                                  id: snapshot
                                                      .data?.docs[index].id,
                                                  type: type,
                                                  currentUserId: uid,
                                                  username: name!,
                                                )),
                                      );
                                    }
                                  },
                                  child: Text(
                                      "${user["firstname"]} ${user["lastname"]}",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black)))
                            ]));
                      }
                      return Container();
                    });
              }),
          ListTile(
            tileColor: Colors.green[100],
            title: const Text('Logout',
                style: TextStyle(fontSize: 17, color: Colors.black)),
            onTap: () {
              context.read<AuthProvider>().signOut();
              Navigator.pop(context);
            },
          ),
        ])),
        appBar: AppBar(title: Text("Profile")),
        // shows the details of the user
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
              friends = snapshot.data!["friends"];
              recFriendReq = snapshot.data!["recFriendReq"];
              sentFriendReq = snapshot.data!["sentFriendReq"];
              int ts = snapshot.data!["bday"].millisecondsSinceEpoch;
              DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(ts);
              bday = tsdate.month.toString() + "/" + tsdate.day.toString() + "/" + tsdate.year.toString();
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
                                            uid,
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
                  height: 20.0,
                ),
                Card(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, TodoPage.routeName,
                          arguments: ScreenArguments(uid, name!));
                    },
                    child: Text("Todo",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // show the list of friends
                ListTile(
                    title: Text("Friend List",
                        style: TextStyle(fontSize: 20, color: Colors.green))),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: friends.length,
                    itemBuilder: (BuildContext context, int index) {
                      Future<DocumentSnapshot<Object?>> friend = context
                          .watch<UserProvider>()
                          .getusername(friends[index]);
                      return FutureBuilder(
                          future: friend,
                          builder: (context, snapshotF) {
                            if (snapshotF.hasError) {
                              return Center(
                                child: Text(
                                    "Error encountered! ${snapshotF.error}"),
                              );
                            } else if (snapshotF.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (!snapshotF.hasData) {
                              return Center(
                                child: Text("No Friend Found"),
                              );
                            }
                            ;
                            return Container(
                                margin: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                                width: 50,
                                child: Row(children: [
                                  Icon(Icons.person),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FriendProfilePage(
                                                    id: friends[index],
                                                    type: "friend",
                                                    currentUserId: uid,
                                                    username: name!,
                                                  )),
                                        );
                                      },
                                      child: Text(
                                          "${snapshotF.data!["firstname"]} ${snapshotF.data!["lastname"]}",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black)))
                                ]));
                          });
                    }),
                SizedBox(
                  height: 20.0,
                ),
                //shows the list of friend requests
                ListTile(
                    title: Text("Friend Request",
                        style: TextStyle(fontSize: 20, color: Colors.green))),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: recFriendReq.length,
                    itemBuilder: (BuildContext context, int index) {
                      Future<DocumentSnapshot<Object?>> friend = context
                          .watch<UserProvider>()
                          .getusername(recFriendReq[index]);
                      return FutureBuilder(
                          future: friend,
                          builder: (context, snapshotF) {
                            if (snapshotF.hasError) {
                              return Center(
                                child: Text(
                                    "Error encountered! ${snapshotF.error}"),
                              );
                            } else if (snapshotF.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (!snapshotF.hasData) {
                              return Center(
                                child: Text("No Friend Found"),
                              );
                            }
                            ;
                            return Container(
                                margin: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                                width: 50,
                                child: Row(children: [
                                  Icon(Icons.person),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FriendProfilePage(
                                                    id: recFriendReq[index],
                                                    type: "recFriendReq",
                                                    currentUserId: uid,
                                                    username: name!,
                                                  )),
                                        );
                                      },
                                      child: Text(
                                          "${snapshotF.data!["firstname"]} ${snapshotF.data!["lastname"]}",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black)))
                                ]));
                          });
                    }),
              ]);
            }));
  }
}

//function that checks if a user id is present in the list
bool checkType(List<dynamic> people, String? person) {
  for (var p = 0; p < people.length; p++) {
    if (people[p] == person) {
      return true;
    }
  }
  return false;
}
