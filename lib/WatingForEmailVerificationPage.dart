import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ColorPalet.dart';
import 'home.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  bool test = FirebaseAuth.instance.currentUser != null &&
      FirebaseAuth.instance.currentUser!.emailVerified;
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
  Widget build(BuildContext context) {
    _checkEmailVerified(FirebaseAuth.instance.currentUser!);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    Icons.email_outlined,
                    size: 140,
                    color: Color.fromARGB(255, 139, 138, 138),
                  ),
                ),
                Container(
                  width: 400,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Please check your email and verify your account.',
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.justify,
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            padding: EdgeInsets.all(5),
                            child: CircularProgressIndicator(
                              color: ColorPalet().color1,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Text(
                            'send again .',
                            style: TextStyle(
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                            textAlign: TextAlign.left,
                          ),
                          onTap: () {
                            FirebaseAuth.instance.currentUser
                                ?.sendEmailVerification();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
