import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../Constants/variables_constants.dart';

class CustomReactiveTextField extends StatelessWidget {
  String controlName,hintText;
  IconData prefixIcon;
  bool obscureText;
  CustomReactiveTextField({this.controlName,this.hintText,this.prefixIcon,this.obscureText=false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: ReactiveTextField(
        validationMessages:VALIDATE_MESSAGES,
        formControlName: controlName,
        style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.blue[900]),
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius:BorderRadius.circular(10.0) ,
              borderSide: BorderSide(
                  color: Colors.black
              )
          ),
          filled: true,
          fillColor: Colors.white,
          focusedBorder:OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.lightBlueAccent
              )
          ),
          prefixIcon: Icon(prefixIcon,color: Colors.blue[900],),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.headline3.copyWith(color: Colors.blue[900]),
        ),

      ),
    );
  }
}
