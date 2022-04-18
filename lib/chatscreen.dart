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
          //display messages
          Container(
              height: 628,
              //color: Colors.blueAccent,

              child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  reverse: true,
                  child: ShowMessages())),

          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.green, width: 2))),
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
                        "messages": msg.text.trim(),
                        "user": loginUser!.email.toString(),
                        "time": DateTime.now(),
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

class ShowMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        // ordered the messages that sent message show in the bottom
        stream: FirebaseFirestore.instance
            .collection("Messages").orderBy('time').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              //reverse: true,
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              primary: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, i) {
                QueryDocumentSnapshot x = snapshot.data!.docs[i];

                return Column( 
          
                  //if user is as himself then text show in the end
                  //else other user's chat show in the start
                  // mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: loginUser!.email == x['user']
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,

                  children: [
                    SizedBox(height: 10,),
                    Container(
                      
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),

                        decoration: BoxDecoration(
                          //if use as self it shows blue else amber
                        color: loginUser!.email == x['user']
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.amber.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(x['messages'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                            SizedBox(
                              height: 5,),
                            Text(
                              "User: "+x['user'],
                              style: TextStyle(fontSize: 10,color: Colors.indigo),
                              ),
                          ],)
                        ),
                  ],
                );
              });
        });
  }
}
