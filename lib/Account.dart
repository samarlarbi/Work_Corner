import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Home.dart';
import 'main.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        leading: IconButton(
          // ignore: prefer_const_constructors
          color: Colors.blueGrey,
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            ); // Navigate back when the back button is pressed
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Column(
              children: [
                Center(
                  child: Image.asset(
                    './images/men.jpg',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            ListTile(
              onTap: () async {
                GoogleSignIn googleSignIn = GoogleSignIn();
                googleSignIn.disconnect();

                await FirebaseAuth.instance.signOut();

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LandingPage()),
                  (Route<dynamic> route) => false,
                );
              },
              leading: Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: Text(
                "Log out",
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ColorPalet {}
