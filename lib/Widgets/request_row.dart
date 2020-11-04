import 'package:bus_reservation_systerm/Constants/text_style_constants.dart';
import 'package:flutter/material.dart';

class RequestRow extends StatelessWidget {
  final IconData icon;
  final String title;

  RequestRow({this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.blue[900],
            size: 40.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
          ),
          Text(
            title,
            style: kBoldBlackStyle,
          ),
        ],
      ),
    );
  }
}
