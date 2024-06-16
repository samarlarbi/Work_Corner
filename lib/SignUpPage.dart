import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_corner/main.dart';

import 'ColorPalet.dart';
import 'Custominput.dart';
import 'CustomButton.dart';
import 'Home.dart';
import 'WatingForEmailVerificationPage.dart';
import 'login.dart';

final _formkey = GlobalKey<FormState>();

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Future<void> _checkEmailVerified(User user) async {
    await Future.delayed(Duration(seconds: 5));

    user = FirebaseAuth.instance.currentUser!;
    await user.reload();

    if (user.emailVerified) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      _checkEmailVerified(user);
    }
  }

  @override
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();
  TextEditingController email = TextEditingController();
  String errorTextname = "";
  String errorTextemail = "";
  String errorTextpass = "";
  String errorTextcpass = "";
  bool _isVerifying = false;

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
        body: _isVerifying
            ? Verification()
            : SingleChildScrollView(
                child: Container(
                  height: 700,
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign Up.",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: ColorPalet().color1,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CInput(
                                validator: (name) => name!.length < 3
                                    ? "name shoude be at least 3 charactere"
                                    : null,
                                myController: name,
                                name: "new account name",
                                hintText: "name",
                                obscureText: false,
                              ),
                              CInput(
                                validator: (email) => isValidEmail(email!)
                                    ? "email is not valid! "
                                    : null,
                                name: "Email",
                                hintText: "Email",
                                obscureText: false,
                                myController: email,
                              ),
                              CInput(
                                validator: isValidPassword,
                                name: "password",
                                hintText: "password",
                                obscureText: true,
                                myController: pass,
                              ),
                              CInput(
                                validator: (cpass) =>
                                    cpass?.compareTo(pass.text) == false ||
                                            cpass == null
                                        ? "does not match the password!"
                                        : null,
                                name: "confirm Password",
                                hintText: "confirme password",
                                obscureText: true,
                                myController: cpass,
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
                                    .createUserWithEmailAndPassword(
                                  email: email.text,
                                  password: pass.text,
                                );
                                User? user = credential.user;
                                credential.user!.sendEmailVerification();

                                setState(() {
                                  _isVerifying = true;
                                });

                                _checkEmailVerified(user!);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  print('The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  print(
                                      'The account already exists for that email.');
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                          title: "sign Up",
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
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              },
                              child: Text(
                                'login ',
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
                ),
              ));
  }

  bool isValidEmail(String email) {
    return email.contains("@") == false || (email == null || email.isEmpty);
  }

  String? isValidPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    if (!RegExp(r'(?=.*[0-9])').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    if (!RegExp(r'(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null; // Password is valid
  }
}
