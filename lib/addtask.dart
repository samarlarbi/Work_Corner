import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:work_corner/CustomButton.dart';
import 'ColorPalete.dart';
import 'Custominput.dart';
import 'Home.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController time = TextEditingController();
    CollectionReference users = FirebaseFirestore.instance.collection('Tasks');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'title': title.text, // John Doe
            'time': time.text, // Stokes and Sons
          })
          .then((value) => print("Task Added"))
          .catchError((error) => print("Failed to add Task: $error"));
    }

    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_outlined,
                  color: ColorPalete().color1,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings_outlined,
                  color: ColorPalete().color1,
                ))
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.of(context as BuildContext).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Home()),
                (Route<dynamic> route) => false,
              );
            },
            icon: Icon(
              Icons.arrow_back,
              color: ColorPalete().color1,
            ),
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Tasks",
            style: TextStyle(
              color: ColorPalete().color1,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              fontSize: 25.0,
            ),
          )),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(40),
        child: Column(children: [
          CInput(
            hintText: 'title',
            myController: title,
            name: 'Title',
            obscureText: false,
            validator: (String) {
              return null;
            },
          ),
          CInput(
            hintText: 'time',
            myController: time,
            name: 'time',
            obscureText: false,
            validator: (String) {
              return null;
            },
          ),
          CustomButton(
              title: "add",
              bgcolor: ColorPalete().color1,
              titlecolor: Colors.white,
              onPressed: () {
                addUser();
              })
        ]),
      ),
    );
  }
}
