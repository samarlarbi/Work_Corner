import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:work_corner/Home.dart';
import 'package:work_corner/addtask.dart';
import 'package:work_corner/taskTile.dart';

import 'Account.dart';
import 'ColorPalete.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List Tasks = [];
  getTasks() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Tasks').get();
    setState(() {
      Tasks.addAll(querySnapshot.docs);
    });
    print(Tasks);
  }

  @override
  void initState() {
    getTasks();
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
              "Tasks",
              style: TextStyle(
                color: ColorPalete().color1,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
                fontSize: 25.0,
              ),
            )),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context as BuildContext).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => AddTask()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    icon: Icon(Icons.add)),
                ListView.builder(
                  itemCount: Tasks.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return TaskTile(
                      title: Tasks[i]["title"],
                      time: Tasks[i]["time"],
                      color: Colors.blue,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: ColorPalete().color1,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: GNav(
                    padding: EdgeInsets.all(16),
                    backgroundColor: ColorPalete().color1,
                    color: Colors.white,
                    activeColor: Colors.white,
                    tabBackgroundColor: Color.fromRGBO(100, 100, 102, 0.425),
                    tabBorderRadius: 15,
                    tabs: [
                      GButton(
                        icon: Icons.home,
                        text: "Home",
                      ),
                      GButton(
                        icon: Icons.search,
                        text: "Search",
                      ),
                      GButton(
                        icon: Icons.mail_outline_rounded,
                        text: "MESSAGES",
                      ),
                      GButton(
                        icon: Icons.person_2_outlined,
                        text: "accont",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Account()),
                          ); // Navigate back when the back button is pressed
                        },
                      )
                    ]),
              ),
            )));
  }
}
