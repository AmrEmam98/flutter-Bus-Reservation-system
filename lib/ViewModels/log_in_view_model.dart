

import 'package:bus_reservation_systerm/Constants/observer_string_response.dart';
import 'package:bus_reservation_systerm/FirebaseServices/authentcation.dart';
import 'package:bus_reservation_systerm/Screens/user_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel {
  static final loginSubject=PublishSubject<String>();
  static String email = "email", password = 'password';
  final form = FormGroup({
    email: FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    password: FormControl<String>(validators: [
      Validators.required,
      Validators.minLength(6),
    ]),
  });

  logIn(BuildContext context) async {

      bool valid = await Auth.signIn(form.value[email], form.value[password]);
      if (valid) {
        print('Success');
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>UserLoadingScreen()));
      } else {
        Fluttertoast.showToast(msg: "Invalid Email or Password",toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.BOTTOM,backgroundColor: Colors.red,fontSize: 16.0,textColor: Colors.white);
        loginSubject.add(FAIL_RESPONSE);
      }
    return valid;
  }

}
