import 'package:flutter/material.dart';

import 'ColorPalet.dart';

class Task extends StatelessWidget {
  final Color iconColor;
  final Color buttonColor;
  final String taskType;
  final IconData icon;
  final String title;
  final String buttontitle;
  const Task(
      {super.key,
      required this.iconColor,
      required this.taskType,
      required this.icon,
      required this.title,
      required this.buttontitle,
      required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 195, 194, 194)
                .withOpacity(0.2), // Shadow color
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(
          icon,
          color: iconColor,
          size: 30,
        ),
        Padding(padding: EdgeInsets.all(10)),
        Text(
          taskType,
          style: TextStyle(color: Colors.grey),
        ),
        Padding(padding: EdgeInsets.all(5)),
        Text(
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        Padding(padding: EdgeInsets.all(10)),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: buttonColor, // Background color
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
          ),
          onPressed: () {
            // Action to perform
          },
          child: Text(
            buttontitle,
            style: TextStyle(color: iconColor),
          ),
        )
      ]),
    );
  }
}
