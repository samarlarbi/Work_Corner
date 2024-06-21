import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_corner/CustomButton.dart';
import 'ColorPalete.dart';
import 'Custominput.dart';
import 'Home.dart';

class UpdateTask extends StatefulWidget {
  final String taskid;
  final String dtitle;
  final String dtime;
  const UpdateTask(
      {super.key,
      required this.taskid,
      required this.dtitle,
      required this.dtime});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  bool isLoading = false;
  bool done = false;
  TextEditingController title = TextEditingController();
  TextEditingController time = TextEditingController();
  CollectionReference tasks = FirebaseFirestore.instance.collection('Tasks');

  UpdateTask() async {
    isLoading = true;
    setState(() {});
    // Call the user's CollectionReference to add a new user
    await tasks.doc(widget.taskid).update({
      "title": title.text,
      "time": time.text,
    });
    print(isLoading);
    isLoading = false;
    done = true;
    setState(() {});
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Icon(
            Icons.task_alt_outlined,
            color: Colors.green,
          ),
          content: Row(
            children: [
              SizedBox(width: 20),
              Text(
                "Tasks added successfully ",
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.pop(context); // This will only close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    title.text = widget.dtime;
    time.text = widget.dtitle;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            "Update",
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
              title: "Update",
              bgcolor: ColorPalete().color1,
              titlecolor: Colors.white,
              onPressed: () {
                UpdateTask();
              }),
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
        ]),
      ),
    );
  }
}
