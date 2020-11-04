
import 'package:bus_reservation_systerm/Constants/text_style_constants.dart';
import 'package:bus_reservation_systerm/ViewModels/sign_up_view_model.dart';
import 'package:bus_reservation_systerm/Widgets/custom_reactive_text_field.dart';
import 'package:bus_reservation_systerm/Widgets/rounded_button.dart';
import 'package:bus_reservation_systerm/Widgets/select_branch_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final viewModel = SignUpViewModel();

  var selectBranchWidget=SelectBranchWidget(spaceAroud: true,);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Sign up',
          style: kAppBarTextStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ReactiveForm(
            formGroup: viewModel.form,
            child: Column(
              children: <Widget>[
                CustomReactiveTextField(
                  controlName: SignUpViewModel.userName,
                  hintText: 'John doe',
                  prefixIcon: Icons.perm_identity,
                ),
                CustomReactiveTextField(
                  controlName: SignUpViewModel.email,
                  hintText: 'example@example.com',
                  prefixIcon: Icons.email,
                ),
                CustomReactiveTextField(
                  controlName: SignUpViewModel.password,
                  hintText: 'Password',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                ),
                CustomReactiveTextField(
                  controlName: SignUpViewModel.confirmPassword,
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                ),
                selectBranchWidget ,
                RoundedButton(
                  onPressed: () {
                    viewModel.signUp(selectBranchWidget.getDropDownMenuValue());
                    print(selectBranchWidget.getDropDownMenuValue());
                  },
                  buttonText: "Sign up",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

