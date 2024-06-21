import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final String time;
  final Color color;
  final VoidCallback onOkPress;
  const TaskTile(
      {super.key,
      required this.title,
      required this.time,
      required this.color, required this.onOkPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(3),
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
          trailing: Wrap(
            children: [
              Icon(Icons.mode_edit_outline_outlined),
              SizedBox(
                width: 10,
              ),
              IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () {
                  showDialog(
                    
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        icon: Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        content: Row(
                          children: [
                            SizedBox(width: 20),
                            Text(
                              "Are you sure to delete this task ? ",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.pop(
                                  context); // This will only close the dialog
                            },
                          ),
                          TextButton(
                            child: Text(
                              "Yes",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed:
                                onOkPress // This will only close the dialog
                            ,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
