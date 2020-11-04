import 'package:bus_reservation_systerm/Constants/observer_string_response.dart';
import 'package:bus_reservation_systerm/Constants/text_style_constants.dart';
import 'package:bus_reservation_systerm/FirebaseServices/set_data_to_firestore.dart';
import 'package:bus_reservation_systerm/Models/user.dart';
import 'package:bus_reservation_systerm/Provider/user_data_provider.dart';
import 'package:bus_reservation_systerm/Screens/user_loading_screen.dart';
import 'package:bus_reservation_systerm/ViewModels/log_in_view_model.dart';
import 'package:bus_reservation_systerm/Widgets/custom_reactive_text_field.dart';
import 'package:bus_reservation_systerm/Widgets/input_field.dart';
import 'package:bus_reservation_systerm/Widgets/rounded_button.dart';
import 'package:bus_reservation_systerm/Widgets/select_branch_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  TextEditingController userNameController = TextEditingController();
  bool firstTime = true,loading=false;
  String userName,branch;
  var selectBranch;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    branch=Provider.of<UserDataProvider>(context,listen: false).currentUser.branch;
    if(firstTime){
      userName= Provider.of<UserDataProvider>(context,listen: false).currentUser.userName;
      userNameController.text =userName;
      selectBranch = new SelectBranchWidget(spaceAroud: true,initialValue: Provider.of<UserDataProvider>(context).currentUser.branch,textColor: Colors.deepPurple,);
      firstTime=false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: kAppBarTextStyle,
        ),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall:loading ,
        child: SingleChildScrollView(
          child: Container(
            width: screenSize.width,
            height: screenSize.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 80.0,
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.deepPurple,
                    size: 160.0,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  height: 30.0,
                ),
                InputField(
                  controller: userNameController,
                  width: screenSize.width * 0.7,
                  enabledBorderColor: Colors.deepPurple,
                  focusBorderColor: Colors.blue[900],
                  prefixIcon: Icon(
                    Icons.account_circle,
                    color: Colors.deepPurple,
                  ),
                  hintText: 'John doe',

                ),
                SizedBox(
                  height: 30.0,
                ),
                selectBranch,
                SizedBox(
                  height: 30.0,
                ),
                FlatButton(
                  onPressed: () {
                    if(userName.isEmpty==false){
                       Provider.of<UserDataProvider>(context,listen: false).editUser(userNameController.text, selectBranch.getDropDownMenuValue());
                       editProfile(context);
                       setState(() {
                         loading=true;
                       });

                       SetDataToFireStore.setUserSubject.listen((value) {if(value==SUCCESS_RESPONSE){
                         setState(() {
                           loading=false;
                         });
                         Fluttertoast.showToast(msg: "Edited Successfullu",backgroundColor: Colors.green,textColor: Colors.white,gravity: ToastGravity.BOTTOM);
                         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>UserLoadingScreen()), (route) => false);
                       }});


                    }
                  },
                  color: Colors.deepPurple,
                  child: Text(
                    'Save ',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

void editProfile(BuildContext context) {
  SetDataToFireStore.addUserToFireStore(Provider.of<UserDataProvider>(context,listen: false).currentUser);

}
