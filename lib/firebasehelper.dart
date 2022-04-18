import 'package:edulab/chatscreen.dart';
import 'package:edulab/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Service {
  //all firebase auth

  final auth = FirebaseAuth.instance;
  //for create user we define function;
  //it take 3 parameter

  void createuser(context, email, password) async {
    try {
      //when the user create it will go to chatscreen directly not to login page
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Chatscreen()))
              });
    } catch (e) {
      //if it has some error it will show dialog
      errorBox(context, e);
    }
  }

//for login user we define login user function
  void loginuser(context, email, password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Chatscreen()))
              });
    } catch (e) {
      //if it has some error it will show dialog
      errorBox(context, e);
    }
  }

//for sign out

  void signout(context) async {
    try {
      await auth.signOut().then((value) => {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()),
         (route) => false)
      });
    } catch (e) {}
  }

//for displaying error

  void errorBox(context, e) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(e.toString()),
          );
        });
  }
}
