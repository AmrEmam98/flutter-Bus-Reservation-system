



import 'package:bus_reservation_systerm/Constants/collections_path_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RetrieveDataFromFireStore{
  static getUserByID(){
    String userId = FirebaseAuth.instance.currentUser.uid;
    CollectionReference userCollection =
    FirebaseFirestore.instance.collection(USERS_COLLECTION_PATH);
    return userCollection.doc(userId).get();
  }


  static getUserRequestById(){
    String userId = FirebaseAuth.instance.currentUser.uid;
    CollectionReference requestCollection=FirebaseFirestore.instance.collection(REQUESTS_COLLECTION_PATH);

      return requestCollection.doc(userId).get();

  }

  static getLinesByBranch(String branch){
    CollectionReference linesCollection =
    FirebaseFirestore.instance.collection(LINES_COLLECTION_PATH);
    return linesCollection.where("from", isEqualTo: branch).get();
  }


  static getAllPendingUserRequests(){
    CollectionReference requestsCollection =
    FirebaseFirestore.instance.collection(REQUESTS_COLLECTION_PATH);
    return requestsCollection.get();
}
}