import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bus_reservation_systerm/Constants/observer_string_response.dart';
import 'package:bus_reservation_systerm/Constants/text_style_constants.dart';
import 'package:bus_reservation_systerm/Screens/sign_up_screen.dart';
import 'package:bus_reservation_systerm/ViewModels/log_in_view_model.dart';
import 'package:bus_reservation_systerm/Widgets/custom_reactive_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../Widgets/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginViewModel viewModel = LoginViewModel();
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bus Reservation System',
          style:kAppBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,

      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: SingleChildScrollView(
          child: ReactiveForm(
            formGroup: viewModel.form,
            child: Column(
              children: <Widget>[
//              Container(
//                height: MediaQuery.of(context).size.height * 0.20,
//                decoration: BoxDecoration(
//                  color: Colors.blueAccent,
//                  borderRadius: BorderRadius.only(
//                      bottomLeft: Radius.circular(20.0),
//                      bottomRight: Radius.circular(20.0)),
//                ),
//
//              ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Container(
                  padding: EdgeInsets.all(30.0),
                  child: ColorizeAnimatedTextKit(
                    text: [
                      "EVA PHARMA",
                    ],
                    textStyle: TextStyle(
                        fontSize: 50.0,
                        fontFamily: "Horizon"
                    ),
                    colors: [
                      Colors.purple,
                      Colors.blue,
                      Colors.blue[900],
                      Colors.blueAccent,

                    ],
                    repeatForever: true,

                  ),
                ),

                CustomReactiveTextField(
                  controlName: LoginViewModel.email,
                  prefixIcon: Icons.email,
                  hintText: 'example@exmple.com',
                ),
                CustomReactiveTextField(
                  controlName: LoginViewModel.password,
                  prefixIcon: Icons.lock,
                  hintText: 'Password',
                  obscureText: true,
                ),
                RoundedButton(
                  buttonText: "Login",
                  onPressed: () async{
                    if(viewModel.form.valid){
                      setState(() {
                        loading=true;
                      });
                      LoginViewModel.loginSubject.listen((value) {
                        if(value==FAIL_RESPONSE){
                          setState(() {
                            loading=false;
                          });
                        }
                      });

                     viewModel.logIn(context);
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    FlatButton(
                      color: Colors.transparent,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        'Sign up',
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(color: Colors.blue[900]),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

