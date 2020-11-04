


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  String userId;
  String email,userName,branch;

  UserModel({this.userId,this.email, this.userName, this.branch});

  UserModel.fromSnapShot(DocumentSnapshot snapshot){
    userId=snapshot.id;
   email= snapshot.data()['email'];
   userName= snapshot.data()['userName'];
   branch= snapshot.data()['branch'];

  }

  UserModel.fromMap(Map<String,dynamic> data,[String uId=null]){

    userId=uId==null?FirebaseAuth.instance.currentUser.uid:uId;
    email= data['email'];
    userName= data['userName'];
    branch= data['branch'];
  }
  toMap()=>{
    'email':email,
    'userName':userName,
    'branch':branch,

  };
}