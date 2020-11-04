import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  final String text;
  TextView({this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(child: Text(text,style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black54
      ),)),
    );
  }
}
