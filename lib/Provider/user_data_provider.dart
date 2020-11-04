import 'package:bus_reservation_systerm/Constants/request_status.dart';
import 'package:bus_reservation_systerm/Models/line.dart';
import 'package:bus_reservation_systerm/Models/request_model.dart';
import 'package:bus_reservation_systerm/Models/user.dart';
import 'package:bus_reservation_systerm/Models/user_request.dart';
import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier {
  List<Line> lines = List();
  UserModel currentUser = UserModel();
  UserRequest userRequest = UserRequest();

  updateLines(List<Line> newLines) {
    this.lines = newLines;
    notifyListeners();
  }

  void setUser(UserModel currentUser) {
    this.currentUser = currentUser;
    notifyListeners();
  }

  void setRequest(UserRequest request) {
    this.userRequest = request;
    notifyListeners();
  }

  void editUser(String userName, String branch) {
    currentUser.userName = userName;
    currentUser.branch = branch;
    notifyListeners();
  }


  setUserCurrentRequest(String to, String station){
    RequestModel currentRequest=RequestModel(from: currentUser.branch,to: to,status: PENDING,station: station);
    userRequest.currentRequest=currentRequest;
//    notifyListeners();
  }
}
