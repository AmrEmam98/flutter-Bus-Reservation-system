import 'package:bus_reservation_systerm/Constants/collections_path_constants.dart';
import 'package:bus_reservation_systerm/Constants/observer_string_response.dart';
import 'package:bus_reservation_systerm/Models/line.dart';
import 'package:bus_reservation_systerm/Models/user.dart';
import 'package:bus_reservation_systerm/Models/user_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class SetDataToFireStore {

  static final setUserSubject=PublishSubject<String>();
  static final setRequestSubject=PublishSubject<String>();

  static void addUserToFireStore(UserModel user) {
    print(user.userId);
    print(user.userName);
    FirebaseFirestore.instance
        .collection(USERS_COLLECTION_PATH)
        .doc(user.userId)
        .set(user.toMap())
        .then((value) => setUserSubject.add(SUCCESS_RESPONSE));
  }
  static void addLineToFireStore(Line line){
    FirebaseFirestore.instance
        .collection(LINES_COLLECTION_PATH)
        .add(line.toMap());

  }

  static void setUserRequest(UserRequest request){
    FirebaseFirestore.instance
        .collection(REQUESTS_COLLECTION_PATH)
        .doc(request.user.userId)
        .set(request.toMap()).then((value) => {
          setRequestSubject.add(SUCCESS_RESPONSE)
    }).catchError((error){
      setRequestSubject.add(error.toString());
    });

  }
}
