
import 'package:bus_reservation_systerm/Constants/request_status.dart';
import 'package:bus_reservation_systerm/Constants/text_style_constants.dart';
import 'package:bus_reservation_systerm/Models/request_model.dart';
import 'package:bus_reservation_systerm/Models/user.dart';
import 'package:bus_reservation_systerm/Models/user_request.dart';
import 'package:bus_reservation_systerm/Provider/admin_data_provider.dart';
import 'package:bus_reservation_systerm/Provider/user_data_provider.dart';
import 'package:bus_reservation_systerm/Widgets/admin_view_request_card.dart';
import 'package:bus_reservation_systerm/Widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AdminRequestScreen extends StatelessWidget {


  RequestModel pendingRequestModel=RequestModel(to: 'Shoubra',from: "Haram",station: 'Rod El farag',status: PENDING);
  RequestModel acceptedRquest=RequestModel(to: 'Shoubra',from: "Haram",station: 'Rod El farag',status:ACCEPTED);
  RequestModel declinedRequestModel=RequestModel(to: 'Shoubra',from: "Haram",station: 'Rod El farag',status: DECLINED);
  List<RequestModel>reqHistory=List();



  @override
  Widget build(BuildContext context) {
    reqHistory.add(acceptedRquest);
    reqHistory.add(declinedRequestModel);
    reqHistory.add(declinedRequestModel);
    reqHistory.add(declinedRequestModel);
    reqHistory.add(acceptedRquest);
    reqHistory.add(acceptedRquest);
    reqHistory.add(acceptedRquest);
    UserRequest request=UserRequest(
        currentRequest: pendingRequestModel,
        requestHistory: reqHistory,
        user:UserModel(
            userName: 'Amr Emam',
            email: 'amr.emam998@gmail.com'
        )

    );


    List<UserRequest> requests=Provider.of<AdminDataProvider>(context,listen: true).requests;
    return Scaffold(
      appBar: AppBar(
        title: Text('Requests',style: kAppBarTextStyle,),
        centerTitle: true,
      ),
      body: Container(
        child:requests.isEmpty?TextView(text: 'No Requests to show ',): ListView.builder(itemBuilder: (context,index)=>AdminViewRequestCard(userRequest: requests[index],index: index,),itemCount: requests.length,)
      ),
    );
  }
}
