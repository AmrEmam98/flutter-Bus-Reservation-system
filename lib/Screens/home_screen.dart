import 'package:bus_reservation_systerm/Constants/text_style_constants.dart';
import 'package:bus_reservation_systerm/Models/line.dart';
import 'package:bus_reservation_systerm/Provider/user_data_provider.dart';
import 'package:bus_reservation_systerm/Screens/login_screen.dart';
import 'package:bus_reservation_systerm/Screens/profile_screen.dart';
import 'package:bus_reservation_systerm/Screens/user_request_screen.dart';
import 'package:bus_reservation_systerm/Widgets/line_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // dummyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Line> lines = Provider.of<UserDataProvider>(context).lines;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lines From ${Provider.of<UserDataProvider>(context).currentUser.branch}',
          style: kAppBarTextStyle,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Container(
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
            child: LineWidget(lines[index])),
        itemCount: lines.length,
      ),
      drawer: Drawer(
          child: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 10.0),
                  child: UserInfo(),
                ),
                DrawerItem(
                  title: "Profile",
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.deepPurple,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileScreen()));
                    //signOut();
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                DrawerItem(
                  title: "Requests",
                  icon: Icon(
                    Icons.list,
                    color: Colors.deepPurple,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserRequestScreen()));
                    //signOut();
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                DrawerItem(
                  title: "Reset Password",
                  icon: Icon(
                    Icons.lock,
                    color: Colors.deepPurple,
                  ),
                  onTap: () {
                    showAlertDialg(context);
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                DrawerItem(
                  title: "Sign out",
                  icon: Icon(
                    Icons.power_settings_new,
                    color: Colors.red,
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          radius: 50.0,
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.account_circle,
            size: 100.0,
            color: Colors.deepPurple,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(Provider.of<UserDataProvider>(context).currentUser.userName,
            style: TextStyle(color: Colors.blue[900], fontSize: 18.0),
            textAlign: TextAlign.center),
        SizedBox(
          height: 10.0,
        ),
        Text(
          Provider.of<UserDataProvider>(context).currentUser.email,
          style: TextStyle(color: Colors.blue[900], fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}

class DrawerItem extends StatelessWidget {
  String title;
  Icon icon;
  Function onTap;

  DrawerItem({this.title, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: ListTile(
        title: Text(title),
        leading: icon,
        onTap: onTap,
      ),
    );
  }
}

//  void dummyData() {
////    List<String> stations = List();
////    stations.add('St.thresa');
////    stations.add('Rod EL Farag');
////    stations.add('Masara');
////    stations.add('Ramsis');
////    stations.add('Ghamra');
////    stations.add('El Demerdash');
////    stations.add('Abbasya');
////    stations.add('Madinet Nasr');
////    Line line = Line(from: BRANCHES[0], to: "Shoubra", stations: stations);
////    lines.add(line);
////    lines.add(line);
////    lines.add(line);
////    lines.add(line);
////    lines.add(line);
////  }
void showAlertDialg(BuildContext context) {
  String email =
      Provider.of<UserDataProvider>(context, listen: false).currentUser.email;
  Alert(
    context: context,
    type: AlertType.info,
    title: "Confirmation",
    desc:
        "we will sent emati to ${email} to reset your password . Do you want to proceed?.",
    buttons: [
      DialogButton(
          child: Text(
            "Close",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.red),
      DialogButton(
        child: Text(
          "Confirm",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () async {
          Navigator.pop(context);
          bool success = false;
          try {
            await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
            success = true;
          } catch (e) {
            success = false;
          }
          Fluttertoast.showToast(
              msg: success
                  ? "Email sent Successfully"
                  : "Error while Sent email",
              fontSize: 18.0,
              backgroundColor: success ? Colors.green : Colors.red,
              textColor: Colors.white);
        },
        color: Colors.green,
      )
    ],
  ).show();
}
