import 'dart:ui';

import 'package:bus_reservation_systerm/FirebaseServices/retrieve_data_from_fireStore.dart';
import 'package:bus_reservation_systerm/Models/line.dart';
import 'package:bus_reservation_systerm/Models/user.dart';
import 'package:bus_reservation_systerm/Models/user_request.dart';
import 'package:bus_reservation_systerm/Provider/user_data_provider.dart';
import 'package:bus_reservation_systerm/Screens/home_screen.dart';
import 'package:bus_reservation_systerm/Widgets/loadingTextWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserLoadingScreen extends StatelessWidget {
  String branch = "";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetchData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if(snapshot.data.exists){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Provider.of<UserDataProvider>(context, listen: false)
                  .setRequest(UserRequest.fromAsyncSnapshot(snapshot.data));
            });
            }
            return HomeScreen();
          }
          return LoadingTextWidget();
        });
  }



  getLinesFormSnapshot(QuerySnapshot value) {
    List<Line> lines = List();
    value.docs.forEach((element) {
    lines.add(Line.fromSnapshot(element));
    });
    return lines;
  }


 Future<dynamic> _fetchData(BuildContext context) async {
    DocumentSnapshot userDocument =
        await RetrieveDataFromFireStore.getUserByID();
    branch = userDocument.data()['branch'];
    QuerySnapshot linesSnapshot =
        await RetrieveDataFromFireStore.getLinesByBranch(branch);
    getLinesFormSnapshot(linesSnapshot);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserDataProvider>(context, listen: false)
          .updateLines(getLinesFormSnapshot(linesSnapshot));
      Provider.of<UserDataProvider>(context, listen: false)
          .setUser(UserModel.fromSnapShot(userDocument));

    });
    return RetrieveDataFromFireStore.getUserRequestById();
  }
}
