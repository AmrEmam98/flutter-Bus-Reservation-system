
import 'package:bus_reservation_systerm/Constants/text_style_constants.dart';
import 'package:bus_reservation_systerm/Models/request_model.dart';
import 'package:bus_reservation_systerm/Widgets/request_row.dart';
import 'package:flutter/material.dart';
class RequestCard extends StatelessWidget {
 final RequestModel request;
  RequestCard({this.request});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                ),
              ),
              RequestRow(
                title:request.to,
                icon: Icons.directions,
              ),
              RequestRow(
                title:request.station,
                icon: Icons.directions_bus,
              ),
              RequestRow(
                title:request.from,
                icon: Icons.work,
              ),
            ],

          ),
        ),
      ),
    );
  }


}






