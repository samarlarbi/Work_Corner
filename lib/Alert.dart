import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final String text;
  const Alert({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(
        Icons.error,
        color: Colors.red,
      ),
      content: Row(
        children: [
          SizedBox(width: 20),
          Text(
            text,
            style: TextStyle(color: Colors.black),
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
            Navigator.of(context).pop();
          } // This will only close the dialog
          ,
        ),
      ],
    );
    ;
  }
}
