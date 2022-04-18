import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

import 'login.dart';

main() async {
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
  runApp(
       MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
      )
      );
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
