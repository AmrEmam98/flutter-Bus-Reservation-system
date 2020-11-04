

import 'package:firebase_auth/firebase_auth.dart';

class Auth{


  static signUp(String email,String password)async {
    UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
   return userCredential.user.uid;
  }
  static signIn(String email ,String password)async{
    bool valid=false;
   await FirebaseAuth
       .instance
       .signInWithEmailAndPassword(email: email, password: password)
       .then((value) => valid = true)
       .catchError((error){
         print(error.toString());
     valid=false;
   });
   return valid;
  }

}