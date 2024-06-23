import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ColorPalet.dart';

class CInput extends StatefulWidget {
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
  State<CInput> createState() => _CInputState();
}

class _CInputState extends State<CInput> {
  bool show = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        child: Text(
          widget.name,
          style: TextStyle(
              color: ColorPalet().color1,
              fontSize: 17,
              fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        child: TextFormField(
          decoration: InputDecoration(
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: show == false
                          ? Icon(Icons.visibility_off_outlined)
                          : Icon(Icons.visibility_outlined),
                      onPressed: () {
                        if (show == false) {
                          show = true;
                        } else {
                          show = false;
                        }
                        setState(() {});
                      })
                  : null,
              // Add padding inside
              border: InputBorder.none,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorPalet().color2),
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon:
                  widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0),
              )),
          validator: widget.validator,
          controller: widget.myController,
          obscureText: widget.obscureText
              ? show
                  ? false
                  : true
              : false,
        ),
      )
    ]);
  }
}
