import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final String time;
  final Color color;
  const TaskTile(
      {super.key,
      required this.title,
      required this.time,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.red, // Change to your desired color
              width: 5.0,
              // Change to your desired width
            ),
          ),
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 15),
          ),
          subtitle: Text(time),
          trailing: Icon(Icons.mode_edit_outline_outlined),
        ),
      ),
    );
  }
}
