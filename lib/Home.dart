import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:work_corner/Account.dart';
import 'package:work_corner/SmallButton.dart';
import 'package:work_corner/taskPage.dart';
import 'package:work_corner/taskTile.dart';
import 'package:work_corner/taskwidget.dart';

import 'ColorPalete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'WatingForEmailVerificationPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool test = FirebaseAuth.instance.currentUser != null &&
      FirebaseAuth.instance.currentUser!.emailVerified;
  List<QueryDocumentSnapshot> Tasks = [];
  bool isLoading = true;
  bool isLoadingdelet = false;
  getTasks() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Tasks')
        .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();

    Tasks.addAll(querySnapshot.docs);
    isLoading = false;
    setState(() {});
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
    return test
        ? Scaffold(
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
                backgroundColor: Colors.white,
                title: Text(
                  "Work Corner",
                  style: TextStyle(
                    color: ColorPalete().color1,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    fontSize: 25.0,
                  ),
                )),
            body: isLoading == true
                ? Center(
                    child: Text("Loading ... "),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.white,
                          Color.fromARGB(106, 229, 240, 249),
                          Color.fromARGB(95, 232, 231, 248),
                          Color.fromARGB(121, 232, 245, 255),
                          Colors.white,
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(padding: EdgeInsets.all(10), children: [
                      Center(
                        child: Container(
                            //first container Ross
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 195, 194, 194)
                                      .withOpacity(0.2), // Shadow color
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(0, 3), // Shadow position
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Container(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text(
                                      "Ross Geller",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    subtitle: Text(
                                      " Human Resources department",
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                    leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Set the border radius here
                                        child: Image(
                                          image: AssetImage(
                                            "./images/men.jpg",
                                          ),
                                        )),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Clock In "),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  ColorPalete().color3)),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            "clock out ",
                                            style: TextStyle(
                                                color: ColorPalete().color3),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromRGBO(
                                                  247, 248, 255, 0.945))),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            SmallButton(
                                icon: Icons.access_time_filled,
                                title: "Attedance",
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TaskPage()),
                                  );
                                }),
                            SmallButton(
                              icon: Icons.groups_2,
                              title: "team",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                );
                              },
                            ),
                            SmallButton(
                              icon: Icons.more_time_rounded,
                              title: "Attedance",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                );
                              },
                            ),
                            SmallButton(
                              icon: Icons.format_list_bulleted_add,
                              title: "TASKS",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TaskPage()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Text("Tasks",
                            style: TextStyle(
                              color: ColorPalete().color2,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                            )),
                      ),
                      SingleChildScrollView(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Task(
                                iconColor: ColorPalete().color5,
                                taskType: "METTING ",
                                icon: Icons.timelapse_rounded,
                                title: "Manager at 4 PM",
                                buttontitle: "TODAY",
                                buttonColor:
                                    const Color.fromARGB(255, 252, 213, 201)),
                            Padding(padding: EdgeInsets.all(8)),
                            Task(
                                iconColor: ColorPalete().color6,
                                taskType: "DOCUMENT ",
                                icon: Icons.timelapse_rounded,
                                title: "SEND DOCUMENT",
                                buttontitle: "TOMORROW",
                                buttonColor:
                                    const Color.fromARGB(255, 209, 250, 250)),
                            Padding(padding: EdgeInsets.all(8)),
                            Task(
                                iconColor: ColorPalete().color6,
                                taskType: "DOCUMENT ",
                                icon: Icons.timelapse_rounded,
                                title: "SEND DOCUMENT",
                                buttontitle: "TOMORROW",
                                buttonColor:
                                    const Color.fromARGB(255, 209, 250, 250))
                          ],
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: ListView.builder(
                            itemCount: Tasks.length,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return TaskTile(
                                onOkPress: () async {
                                  isLoadingdelet = true;
                                  setState(() {});
                                  await FirebaseFirestore.instance
                                      .collection('Tasks')
                                      .doc(Tasks[i].id)
                                      .delete();

                                  Tasks.removeAt(i);
                                  print(Tasks);
                                  setState(() {});

                                  isLoadingdelet = false;
                                  setState(() {});

                                  Navigator.pop(context);
                                  // This will only close the dialog
                                },
                                title: Tasks[i]["title"],
                                time: Tasks[i]["time"],
                                color: Colors.blue, taskid: Tasks[i].id,
                              );
                            },
                          ),
                        ),
                      )
                    ])),
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
                              MaterialPageRoute(
                                  builder: (context) => Account()),
                            ); // Navigate back when the back button is pressed
                          },
                        )
                      ]),
                ),
              ),
            ),
          )
        : Verification();
  }
}
