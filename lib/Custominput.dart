import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ColorPalet.dart';

class CInput extends StatelessWidget {
  final String name;
  final String hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextEditingController myController;
  final String? Function(String?) validator;

  const CInput(
      {super.key,
      required this.name,
      required this.hintText,
      this.prefixIcon,
      required this.obscureText,
      required this.myController,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
                color: ColorPalet().color1,
                fontSize: 17,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.only(bottom: 20, top: 20),
        height: 30,
        child: TextFormField(
          decoration: InputDecoration(
              // Add padding inside
              border: InputBorder.none,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorPalet().color2),
              ),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0),
              )),
          validator: validator,
          controller: myController,
          obscureText: obscureText,
        ),
      )
    ]);
  }
}
