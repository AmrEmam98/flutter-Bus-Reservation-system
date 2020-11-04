

import 'package:bus_reservation_systerm/Models/line.dart';
import 'package:bus_reservation_systerm/Models/user_request.dart';
import 'package:flutter/cupertino.dart';

class AdminDataProvider extends ChangeNotifier{

  List<Line> lines=List();
  List<UserRequest> requests=List();


  setLines(List<Line>lines){
    this.lines=lines;
    notifyListeners();
  }
  setRequests(List<UserRequest>requests){

    requests.removeWhere((element) => element.currentRequest==null);
    this.requests=requests;
    notifyListeners();
  }

  removeRequest(int index){
    requests.removeAt(index);
    notifyListeners();
  }

}