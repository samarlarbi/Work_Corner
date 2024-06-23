// main.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'ColorPalet.dart';
import 'Home.dart';
import 'SignUpPage.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null ? LandingPage() : Home(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context as BuildContext).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Home()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(68, 65, 113, 1),
              ColorPalet().color2,
              ColorPalet().color2,
              ColorPalet().color3,
              ColorPalet().color3,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50, bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 700,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome.",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Text(
                        "Let's Get Started!",
                        style: TextStyle(
                          color: Color.fromARGB(183, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                          wordSpacing: 2,
                          letterSpacing: 1.5,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 70),
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          "sign up ",
                          style: TextStyle(
                            color: ColorPalet().color1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          signInWithGoogle();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          backgroundColor:
                              const Color.fromARGB(131, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          "sign in with google",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ? ",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  Login()),
                        );
                      },
                      child: Text(
                        'login ',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
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
      ),
    );
  }
}
