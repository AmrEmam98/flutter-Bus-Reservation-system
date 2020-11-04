import 'dart:ui';

import 'package:bus_reservation_systerm/FirebaseServices/retrieve_data_from_fireStore.dart';
import 'package:bus_reservation_systerm/Models/line.dart';
import 'package:bus_reservation_systerm/Models/user.dart';
import 'package:bus_reservation_systerm/Models/user_request.dart';
import 'package:bus_reservation_systerm/Provider/user_data_provider.dart';
import 'package:bus_reservation_systerm/Screens/home_screen.dart';
import 'package:bus_reservation_systerm/Widgets/loadingTextWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class UserLoadingScreen extends StatelessWidget {


  String branch = "";


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RetrieveDataFromFireStore.getUserByID(),
      builder: (BuildContext context, AsyncSnapshot userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.done) {
          branch = userSnapshot.data['branch'];
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<UserDataProvider>(context, listen: false)
                .setUser(UserModel.fromSnapShot(userSnapshot.data));
          });
         return loadRequset();

        }
        return LoadingTextWidget();
      }
        );
      }


  getLines(AsyncSnapshot value) {
    List<Line> lines = List();
    value.data.docs.forEach((element) {
      Line line = Line.fromSnapshot(element);
      print(line.to);
      lines.add(line);
    });
    return lines;
  }






  LoadLines(String branch) {
    return FutureBuilder(
        future: RetrieveDataFromFireStore.getLinesByBranch(branch),
        builder: (BuildContext context, AsyncSnapshot linesSnapShot) {
          if (linesSnapShot.connectionState == ConnectionState.done) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Provider.of<UserDataProvider>(context, listen: false)
                  .updateLines(getLines(linesSnapShot));
            });
            return HomeScreen();
          }
          return LoadingTextWidget();
        });
  }
  FutureBuilder loadRequset(){
    return FutureBuilder(
      future: RetrieveDataFromFireStore.getUserRequestById(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if(!snapshot.data.exists)
          {
            print('error');
            return LoadLines(branch);
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<UserDataProvider>(context, listen: false)
                .setRequest(UserRequest.fromAsyncSnapshot(snapshot.data));
          });
          return LoadLines(branch);
        }
        return LoadingTextWidget();
      },

    );
  }
}

