import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ColorPalet.dart';
import 'Custominput.dart';
import 'CustomButton.dart';
import 'Home.dart';
import 'SignUpPage.dart';
import 'main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();
  String errorTextemail = "";
  String errorTextpass = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          // ignore: prefer_const_constructors
          color: ColorPalet().color1,
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LandingPage()),
            ); // Navigate back when the back button is pressed
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        height: 700,
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login.",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: ColorPalet().color1,
              ),
            ),
            Container(
              child: Column(
                children: [
                  CInput(
                    myController: email,
                    name: "email",
                    hintText: "email",
                    obscureText: false,
                    validator: (email) =>
                        isValidEmail(email!) ? "email is not valid! " : null,
                  ),
                  CInput(
                    validator: (pass) =>
                        pass!.length < 8 ? "email is not valid! " : null,
                    myController: pass,
                    name: "password",
                    hintText: "password",
                    obscureText: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email.text);
                        },
                        child: Text(
                          "forget the password? ",
                          style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            CustomButton(
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email.text, password: pass.text);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  }
                },
                title: "Login",
                bgcolor: ColorPalet().color1,
                titlecolor: Colors.white),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ? ",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 162, 161, 161),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text(
                      'sign Up ',
                      style: TextStyle(
                        color: ColorPalet().color1,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email!) || (email == null || email.isEmpty);
  }
}
