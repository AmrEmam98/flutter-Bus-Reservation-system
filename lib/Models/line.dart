

import 'package:cloud_firestore/cloud_firestore.dart';

class Line{
  String id,from,to;
  List<String>stations;

  Line({this.from, this.to, this.stations});
  Line.fromSnapshot(DocumentSnapshot snapshot){
    id=snapshot.id;
    from= snapshot.data()['from'];
    to= snapshot.data()['to'];
    stations= List.from(snapshot.data()['stations']);
  }

  toMap()=>{
    'from':from,
    'to':to,
    'stations':stations,
  };
  @override
  String toString() {
    print('From : $from     to: $to');
  }
}