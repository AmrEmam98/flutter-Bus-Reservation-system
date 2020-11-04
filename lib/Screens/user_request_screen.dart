import 'package:bus_reservation_systerm/Constants/request_status.dart';
import 'package:bus_reservation_systerm/Constants/text_style_constants.dart';
import 'package:bus_reservation_systerm/FirebaseServices/set_data_to_firestore.dart';
import 'package:bus_reservation_systerm/Models/request_model.dart';
import 'package:bus_reservation_systerm/Models/user.dart';
import 'package:bus_reservation_systerm/Models/user_request.dart';
import 'package:bus_reservation_systerm/Provider/user_data_provider.dart';
import 'package:bus_reservation_systerm/Widgets/admin_view_request_card.dart';
import 'package:bus_reservation_systerm/Widgets/request_card.dart';
import 'package:bus_reservation_systerm/Widgets/text_view.dart';
import 'package:bus_reservation_systerm/Widgets/user_view_request_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserRequestScreen extends StatelessWidget
{
//  RequestModel pendingRequestModel=RequestModel(to: 'Shoubra',from: "Haram",station: 'Rod El farag',status: PENDING);
//  RequestModel acceptedRquest=RequestModel(to: 'Shoubra',from: "Haram",station: 'Rod El farag',status:ACCEPTED);
//  RequestModel declinedRequestModel=RequestModel(to: 'Shoubra',from: "Haram",station: 'Rod El farag',status: DECLINED);
//  List<RequestModel>reqHistory=List();


  @override
  Widget build(BuildContext context) {
//    reqHistory.add(acceptedRquest);
//    reqHistory.add(declinedRequestModel);
//    reqHistory.add(declinedRequestModel);
//    reqHistory.add(declinedRequestModel);
//    reqHistory.add(acceptedRquest);
//    reqHistory.add(acceptedRquest);
//    reqHistory.add(acceptedRquest);
//    UserRequest request=UserRequest(
//      currentRequest: pendingRequestModel,
//      requestHistory: reqHistory,
//      user:UserModel(
//        userName: 'Amr Emam',
//        userId: FirebaseAuth.instance.currentUser.uid,
//        email: 'amr.emam998@gmail.com'
//      )

//    );

    UserRequest request=Provider.of<UserDataProvider>(context).userRequest;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Requests',
          style: kAppBarTextStyle,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Pending Request",
              style: kAppBarTextStyle,
            ),
          ),
          request.currentRequest!=null?UserViewRequestCard(request: request.currentRequest,):TextView(text: 'No Pending Requests',),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Visibility(
              visible: request.requestHistory.length!=0,
              child: Text(
                "Request History",
                style: kAppBarTextStyle,
              ),
            ),
          ),
       ...request.requestHistory.map((req) => UserViewRequestCard(request: req,)).toList(),
        ],
      ),
    );

  }
}



