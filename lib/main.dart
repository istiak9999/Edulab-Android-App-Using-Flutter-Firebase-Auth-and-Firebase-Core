import 'package:edulab/chatscreen.dart';
import 'package:edulab/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

import 'login.dart';
import 'register.dart';

main() async {
  //in main we will check if the user email is present in the key
  // then go to chatscreen else login screen
  //here in the app when we restart the app it will goto login page
  //for this we will take email from key the email is remove from key when the user click logOut
  // it present all the time


  //intialize firebase
  WidgetsFlutterBinding.ensureInitialized();
  //also add multi dex in the gradle
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCWUZuM_B-pdVs_XGcFVuMbDTD3CplXg3Y", //  apiKey
      appId: "1:141652131858:android:9065ef9a3348ccca8718cb", // Your appId
      messagingSenderId: "141652131858", // Your messagingSenderId
      projectId: "edulab-b84ef", // Your projectId
    ),
  );

  
  SharedPreferences pref = await SharedPreferences.getInstance();
  //getting email from email key

  var email = pref.getString("email");


  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    //when email is null it will go to login else ChatScreen
    //now if we restart or close our app and again open the app it will  directly go to ChatScreen 
    //if we logout then restart the app its go to loginpage


    home:email==null? LoginPage():Chatscreen(),
  ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LoginPage(),
//     );
//   }
// }
