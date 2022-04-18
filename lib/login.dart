import 'package:flutter/material.dart';
import 'register.dart';
import 'firebasehelper.dart';
class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Service service=Service();


    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
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
                onPressed: () {
                  // if email and password is not empty i will take action on it
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    service.loginuser(
                        context, emailController.text, passwordController.text);
                  } else {
                    // if textfields are empty it show warning message

                    service.errorBox((context), "Fields must not be. Please provide valid email and password");
                  }
                },

                child: Text('Login')),
            TextButton(
                onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(),));
                },
                child: Text('I dont have any account?')),
          ],
        ),
      ),
    ));
  }
}