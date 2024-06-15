import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:work_corner/SmallButton.dart';
import 'package:work_corner/taskwidget.dart';

import 'ColorPalet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_outlined,
                  color: ColorPalet().color1,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings_outlined,
                  color: ColorPalet().color1,
                ))
          ],
          backgroundColor: Colors.white,
          title: Text(
            "Work Corner",
            style: TextStyle(
              color: ColorPalet().color1,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              fontSize: 25.0,
            ),
          )),
      body: Container(
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
                                    backgroundColor: ColorPalet().color3)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "clock out ",
                                  style: TextStyle(color: ColorPalet().color3),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(247, 248, 255, 0.945))),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SmallButton(
                      icon: Icons.access_time_filled, title: "Attedance"),
                  SmallButton(icon: Icons.groups_2, title: "team"),
                  SmallButton(
                      icon: Icons.more_time_rounded, title: "Attedance"),
                  SmallButton(
                      icon: Icons.access_time_filled, title: "Attedance"),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Text("Tasks",
                  style: TextStyle(
                    color: ColorPalet().color2,
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                  )),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Task(
                      iconColor: ColorPalet().color5,
                      taskType: "METTING ",
                      icon: Icons.timelapse_rounded,
                      title: "Manager at 4 PM",
                      buttontitle: "TODAY",
                      buttonColor: const Color.fromARGB(255, 252, 213, 201)),
                  Padding(padding: EdgeInsets.all(8)),
                  Task(
                      iconColor: ColorPalet().color6,
                      taskType: "DOCUMENT ",
                      icon: Icons.timelapse_rounded,
                      title: "SEND DOCUMENT",
                      buttontitle: "TOMORROW",
                      buttonColor: const Color.fromARGB(255, 209, 250, 250)),
                  Padding(padding: EdgeInsets.all(8)),
                  Task(
                      iconColor: ColorPalet().color6,
                      taskType: "DOCUMENT ",
                      icon: Icons.timelapse_rounded,
                      title: "SEND DOCUMENT",
                      buttontitle: "TOMORROW",
                      buttonColor: const Color.fromARGB(255, 209, 250, 250))
                ],
              ),
            )
          ])),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: ColorPalet().color1,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: GNav(
                padding: EdgeInsets.all(16),
                backgroundColor: ColorPalet().color1,
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Color.fromRGBO(100, 100, 102, 0.425),
                tabBorderRadius: 15,
                tabs: const [
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
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
