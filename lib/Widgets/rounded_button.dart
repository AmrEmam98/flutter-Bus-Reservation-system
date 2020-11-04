import 'package:flutter/material.dart';


class RoundedButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;

  RoundedButton({
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: FlatButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.blue)),
        onPressed:onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
              color: Colors.blue[800],
              letterSpacing: 3,
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
