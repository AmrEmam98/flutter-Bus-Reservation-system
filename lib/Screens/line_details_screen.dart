
import 'package:bus_reservation_systerm/Constants/observer_string_response.dart';
import 'package:bus_reservation_systerm/Constants/request_status.dart';
import 'package:bus_reservation_systerm/Constants/text_style_constants.dart';
import 'package:bus_reservation_systerm/FirebaseServices/set_data_to_firestore.dart';
import 'package:bus_reservation_systerm/Models/line.dart';
import 'package:bus_reservation_systerm/Models/request_model.dart';
import 'package:bus_reservation_systerm/Models/user.dart';
import 'package:bus_reservation_systerm/Models/user_request.dart';
import 'package:bus_reservation_systerm/Provider/user_data_provider.dart';
import 'package:bus_reservation_systerm/Screens/user_loading_screen.dart';
import 'package:bus_reservation_systerm/Screens/user_request_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:provider/provider.dart';

class LineDetailsScreen extends StatefulWidget {
  Line lineModel;

  LineDetailsScreen({this.lineModel});

  @override
  _LineDetailsScreenState createState() => _LineDetailsScreenState();
}

class _LineDetailsScreenState extends State<LineDetailsScreen> {
  bool loading = false;
   GlobalKey<ScaffoldState> _scaffoldKey ;
  @override
  Widget build(BuildContext context) {
    _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue[900]),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          '${widget.lineModel.to}',
          style: kAppBarTextStyle,
        ),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Text(
                  'Select pick-up point',
                  style: kBoldBlackStyle,
                ),
              ),
              ...widget.lineModel.stations
                  .map((station) => Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 7.0),
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 10.0),
                          padding: EdgeInsets.all(10.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.directions_bus,
                              color: Colors.blue[900],
                              size: 40,
                            ),
                            title: Text(
                              station,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            trailing: RaisedButton(
                              color: Colors.green,
                              onPressed: () {
                                showAlertDialg(context, station);
                                SetDataToFireStore.setRequestSubject.listen((value) {
                                  if (value == SUCCESS_RESPONSE) {
                                    //_showToast(_scaffoldKey.currentContext);
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>UserRequestScreen()), (route) => false);
                                  }
                                  setState(() {
                                    loading = false;
                                  });
                                  print(value);
                                });
                              },
                              child: Text(
                                'Select',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  void showAlertDialg(BuildContext dialogContext, String pickUpPoint) {
    Alert(
      context: dialogContext,
      type: AlertType.info,
      title: "Confirmation",
      desc: "Do you want to confirm $pickUpPoint as your pick up point.",
      buttons: [
        DialogButton(
            child: Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(dialogContext),
            color: Colors.red),
        DialogButton(
          child: Text(
            "Confirm",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            doActualRequest( this.widget.lineModel.to, pickUpPoint);
            Navigator.of(dialogContext).pop();
            setState(() {
              loading = true;
            });
          },
          color: Colors.green,
        )
      ],
    ).show();
  }

  void doActualRequest( String line, String station) {

      Provider.of<UserDataProvider>(_scaffoldKey.currentContext, listen: false)
          .setUserCurrentRequest(line, station);
    SetDataToFireStore.setUserRequest(
        Provider.of<UserDataProvider>(_scaffoldKey.currentContext, listen: false).userRequest);
  }
}

void _showToast(BuildContext toastContext) {
  Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.green,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            "Your request has been sent",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ));
  FToast fToast = FToast();
  fToast.init(toastContext);
  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 3),
  );
}
