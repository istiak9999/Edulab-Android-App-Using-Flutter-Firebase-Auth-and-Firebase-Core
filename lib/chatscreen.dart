import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'register.dart';
import 'firebasehelper.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class Chatscreen extends StatefulWidget {
  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  Service service = Service();

  final storeMessage = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  TextEditingController msg = TextEditingController();

  //For current user
  getCurrentUser() {
    final user = auth.currentUser;

    //if user not empty it assign to login user

    if (user != null) {
      loginUser = user;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () async {
                service.signout(context);
                //here we remove that email from the key wen user click logOut button
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove("email");
                //it will remove user email when user click logout button
              },
              icon: Icon(Icons.logout))
        ],
        title: Text(loginUser!.email.toString()),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Messages'),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.green, width: 0.2))),
                  child: TextField(
                    controller: msg,
                    decoration: InputDecoration(hintText: 'Enter Message....'),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    if (msg.text.isNotEmpty) {
                      storeMessage.collection("Messages").doc().set({
                        "messages":msg.text.trim(),
                        "user":loginUser!.email.toString(),
                      });
                      msg.clear();
                    }
                  },
                  icon: Icon(Icons.send, color: Colors.green[700])),
            ],
          ),
        ],
      ),
    );
  }
}
