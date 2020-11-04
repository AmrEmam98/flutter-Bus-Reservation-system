import 'package:bus_reservation_systerm/Constants/request_status.dart';
import 'package:bus_reservation_systerm/FirebaseServices/set_data_to_firestore.dart';
import 'package:bus_reservation_systerm/Models/user.dart';
import 'package:bus_reservation_systerm/Models/user_request.dart';
import 'package:bus_reservation_systerm/Provider/admin_data_provider.dart';
import 'package:bus_reservation_systerm/Widgets/request_card.dart';
import 'package:bus_reservation_systerm/Widgets/request_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminViewRequestCard extends StatelessWidget {
  final UserRequest userRequest;
  int index;
  AdminViewRequestCard({@required this.userRequest,this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 15.0,
        child: Column(
          children: <Widget>[
            Container(
              height: 3.0,
              color: Colors.blue[900],
            ),
            _UserInfoView(user: userRequest.user),
            RequestCard(
              request: userRequest.currentRequest,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              color: Color(0xFFF2F2F2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      requestResponding(DECLINED, context);
                    },
                    color: Colors.red,
                    child: Text(
                      'Decline',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                  ),
                  RaisedButton(
                    onPressed: () {
                      requestResponding(ACCEPTED,context);
                    },
                    color: Colors.green,
                    child: Text(
                      'Accept',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  requestResponding(String respond,BuildContext context){
    userRequest.requestResponding(respond);
    SetDataToFireStore.setUserRequest(userRequest);
    Provider.of<AdminDataProvider>(context,listen: false).removeRequest(index);
  }
}

class _UserInfoView extends StatelessWidget {
final UserModel user;
_UserInfoView({@required this.user});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 8.0),
      child: Column(
        children: <Widget>[
          RequestRow(
            icon: Icons.account_circle,
            title: user.userName,
          ),
          RequestRow(
            icon: Icons.email,
            title: user.email,
          ),
        ],
      ),
    );
  }
}
