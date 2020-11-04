

import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel{
  String status;
  String station,from,to;

  RequestModel({this.from,this.to,this.station,this.status});

  RequestModel.fromSnapShot(DocumentSnapshot snapshot){
    status=snapshot['status'];
    station=snapshot['station'];
    from=snapshot['from'];
    to=snapshot['to'];
  }
  RequestModel.fromMap(Map<String,dynamic> data){
    status=data['status'];
    station=data['station'];
    from=data['from'];
    to=data['to'];
  }

  toMap()=>{
    'status':status,
    'station':station,
    'from':from,
    'to':to,

  };

}