import 'package:flutter/material.dart';

import 'ColorPalet.dart';

class SmallButton extends StatelessWidget {
  final IconData icon;
  final String title;
  const SmallButton({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(3),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 197, 195, 195)
                  .withOpacity(0.2), // Shadow color
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 5), // Shadow position
            ),
          ],
        ),
        child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(5),
                backgroundColor: Colors.white,
                elevation: 0),
            child: Column(children: [
              Icon(
                icon,
                size: 30,
                color: ColorPalet().color3,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w700),
              ),
            ])),
      ),
    );
  }
}
