

import 'package:bus_reservation_systerm/Models/request_model.dart';
import 'package:bus_reservation_systerm/Models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserRequest{
  UserModel user;
  RequestModel currentRequest;
  List<RequestModel> requestHistory;
  UserRequest({this.user,this.currentRequest,this.requestHistory}){
    requestHistory=requestHistory==null?List():requestHistory;
  }



  UserRequest.fromAsyncSnapshot(dynamic snapshot){
    user=UserModel.fromMap(snapshot['user']);
    currentRequest=snapshot['currentRequest']==null?null:RequestModel.fromMap(snapshot['currentRequest']);
    if(snapshot['requestHistory']==null)
      {
        requestHistory=List();
      }
    else{
      List<Map<String,dynamic>> reqHistory=List.from(snapshot['requestHistory']);
      this.requestHistory= reqHistory.map((e) => RequestModel.fromMap(e)).toList();
    }
  }
  toMap()=>{
    "user":user.toMap(),
    "currentRequest":currentRequest==null?null:currentRequest.toMap(),
    "requestHistory":requestHistory.map((e) => e.toMap()).toList(),
  };

  requestResponding(String requestStatus){
    currentRequest.status=requestStatus;
    requestHistory.add(currentRequest);
    currentRequest=null;
  }






}