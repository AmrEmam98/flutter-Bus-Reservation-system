import 'package:flutter/material.dart';


class InputField extends StatelessWidget {
  InputField({
    this.width,
    this.enabledBorderColor,
    this.focusBorderColor,
    this.hintText="Shoubra",
    this.labelText=null,
    this.prefixIcon=null,
    @required this.controller,
  });
  final TextEditingController controller;
  final double width;
  final Color enabledBorderColor;
  final Color focusBorderColor;
  final String hintText;
  final String labelText;
  final Widget prefixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: labelText,
          hintText: hintText,

          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: enabledBorderColor, width: 2.0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: focusBorderColor, width: 1.0)),
        ),
      ),
    );
  }
}
