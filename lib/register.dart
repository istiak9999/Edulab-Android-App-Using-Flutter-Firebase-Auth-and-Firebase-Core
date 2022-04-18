import 'package:edulab/firebasehelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class RegisterPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // here we take intance  of service class

  Service service = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign-UP',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter Your Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Enter Your Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            ElevatedButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                ),
                onPressed: () async{

                  SharedPreferences pref =await SharedPreferences.getInstance();

                  // if email and password is not empty i will take action on it
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    service.createuser(
                        context, emailController.text, passwordController.text);

                    //save user email in email key
                    //from this key we will check if email is present in the key goto chatScreen ,else loginPage
                    pref.setString("email", emailController.text);                    

                  } else {
                    // if textfields are empty it show warning message

                    service.errorBox((context), "Fields must not be. Please provide valid email and password");
                  }
                },
                child: Text('Register')),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                },
                child: Text('Already have an account?')),
          ],
        ),
      ),
    ));
  }
}
