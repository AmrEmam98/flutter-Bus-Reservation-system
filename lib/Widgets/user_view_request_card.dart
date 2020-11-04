import 'package:bus_reservation_systerm/Constants/request_status.dart';
import 'package:bus_reservation_systerm/Constants/text_style_constants.dart';
import 'package:bus_reservation_systerm/Models/request_model.dart';
import 'package:bus_reservation_systerm/Widgets/request_card.dart';
import 'package:flutter/material.dart';

class UserViewRequestCard extends StatelessWidget {
 final RequestModel request;
  UserViewRequestCard({this.request});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 15.0,
        child: Column(
          children: <Widget>[
            RequestCard(request: request,),
            _UserViewRow(status: request.status,),
          ],
        ),
      ),
    );
  }
}
class _UserViewRow extends StatelessWidget {
  final String status;
  _UserViewRow({@required this.status});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF2F2F2),
      height: MediaQuery.of(context).size.height*0.06,
      padding: EdgeInsets.only(left: 16.0,right:8.0 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Status:',style:kBoldBlackStyle),
          Text(status,style:kBoldBlackStyle.copyWith(color: getRequestStatusColor(status)))
        ],
      ),
    );
  }
  getRequestStatusColor(String status) {
    switch (status) {
      case PENDING:
        return Colors.black;
        break;
      case ACCEPTED:
        return Colors.green;
        break;
      case DECLINED:
        return Colors.red;
        break;
    }
  }
}

