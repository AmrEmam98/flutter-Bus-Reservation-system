import 'package:bus_reservation_systerm/Constants/text_style_constants.dart';
import 'package:bus_reservation_systerm/FirebaseServices/set_data_to_firestore.dart';
import 'package:bus_reservation_systerm/Models/line.dart';
import 'package:bus_reservation_systerm/Widgets/select_branch_widget.dart';
import 'package:bus_reservation_systerm/Widgets/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddLineScreen extends StatefulWidget {
  @override
  _AddLineScreenState createState() => _AddLineScreenState();
}

class _AddLineScreenState extends State<AddLineScreen> {
  var selectBranchWidget = SelectBranchWidget(
    spaceAroud: false,
  );

  List<String> stations = List();

  TextEditingController stationNameController = TextEditingController();

  TextEditingController toController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Line',
          style: kAppBarTextStyle,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save_alt,
              color: Colors.deepPurple,
            ),
            onPressed: () {
              if(dataValid())
              showConfirmDialog(context);
              else{
                Fluttertoast.showToast(
                    msg: "Please Enter Valid Data",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              selectBranchWidget,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'To:',
                    style: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  InputField(
                    controller: toController,
                    width: screenSize.width * 0.5,
                    focusBorderColor: Colors.deepPurple,
                    enabledBorderColor: Colors.blue[900],
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              Text(
                'Stations:',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0),
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InputField(
                    controller: stationNameController,
                    width: screenSize.width * 0.5,
                    focusBorderColor: Colors.deepPurple,
                    enabledBorderColor: Colors.blue[900],
                  ),
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        stations.add(stationNameController.text);
                        stationNameController.text = "";
                      });
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    color: Colors.green,
                  )
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              Container(
                height: screenSize.height * 0.4,
                child: ListView.builder(
                  itemCount: stations.length,
                  itemBuilder: (_, index) => Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      elevation: 8.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            showEditDialog(context, index);
                          },
                          title: Text(stations[index]),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                stations.removeAt(index);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showConfirmDialog(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Confirmation",
      desc: "Do you want to save this line data ?",
      buttons: [

        DialogButton(
          child: Text(
            "Discard",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.red,
        ),     DialogButton(
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){


              Navigator.pop(context);
              Line line=Line(
                from: selectBranchWidget.getDropDownMenuValue(),
                to: toController.text,
                stations: stations,
              );
              SetDataToFireStore.addLineToFireStore(line);

            },
            color: Colors.green),
      ],
    ).show();
  }

  showEditDialog(BuildContext context, int index) {
    TextEditingController editStationController = TextEditingController();
    editStationController.text = stations[index];
    Alert(
        context: context,
        title: "Edit Station Name:",
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              InputField(
                controller: editStationController,
                width: MediaQuery.of(context).size.width * 0.3,
                enabledBorderColor: Colors.deepPurple,
                focusBorderColor: Colors.blue[900],
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.red,
            child: Text(
              "Discard",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          DialogButton(
            onPressed: () {
              setState(() {
                stations[index] = editStationController.text;
              });
              Navigator.pop(context);
            },
            color: Colors.green,
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  bool dataValid() {
    if(toController.text==''||stations.isEmpty)
      return false;
    return true;
  }
}
