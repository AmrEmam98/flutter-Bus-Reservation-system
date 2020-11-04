import 'package:bus_reservation_systerm/FirebaseServices/retrieve_data_from_fireStore.dart';
import 'package:bus_reservation_systerm/Models/user_request.dart';
import 'package:bus_reservation_systerm/Provider/admin_data_provider.dart';
import 'package:bus_reservation_systerm/Screens/admin_request_screen.dart';
import 'package:bus_reservation_systerm/Widgets/loadingTextWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminLoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RetrieveDataFromFireStore.getAllPendingUserRequests(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Provider.of<AdminDataProvider>(context, listen: false)
                  .setRequests(getRequests(snapshot));
            });
            return AdminRequestScreen();
        }
        return LoadingTextWidget();
      },
    );
  }

  getRequests(dynamic snapshot) {
    List<UserRequest> requests = List();
      snapshot.data.docs.forEach((request) {
        UserRequest userRequest=UserRequest.fromAsyncSnapshot(request);
        userRequest.user.userId=request.id;
        requests.add(userRequest);
      });
    return requests;
  }
}
