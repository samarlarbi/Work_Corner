import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_corner/Alert.dart';

import 'ColorPalet.dart';
import 'Custominput.dart';
import 'CustomButton.dart';
import 'Home.dart';
import 'SignUpPage.dart';
import 'main.dart';

final _formkey = GlobalKey<FormState>();

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  bool done = false;

  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();
  bool _isVerifying = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pass.dispose();
    email.dispose();
  }

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
            Navigator.of(context as BuildContext).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LandingPage()),
              (Route<dynamic> route) => false,
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
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    CInput(
                      myController: email,
                      name: "email",
                      hintText: "email",
                      obscureText: false,
                      validator: (email) => isValidEmail(email!) &&
                              email != null &&
                              email.length != 0
                          ? null
                          : "email is not valid! ",
                    ),
                    CInput(
                      // ignore: unnecessary_null_comparison
                      validator: (email) => pass.text.length == 0
                          ? "password is not valid! "
                          : null,
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
            ),
            CustomButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Alert(
                              text: "No user found for that email.",
                            );
                          },
                        );
                      } else if (e.code == 'wrong-password') {
                        print("nnnn");
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Alert(
                              text: "Wrong password provided for that user.",
                            );
                          },
                        );
                      } else {
                        // Handle other FirebaseAuthException errors
                        print('Firebase Authentication Error: ${e.code}');
                      }
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
            ),
            isLoading == true
                ? AlertDialog(
                    content: Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 20),
                        Text("Loading ..."),
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      )),
    );
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email!) || (email.isEmpty);
  }
}
