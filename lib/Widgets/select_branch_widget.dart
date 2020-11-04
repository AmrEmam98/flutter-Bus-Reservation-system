
import 'package:flutter/material.dart';

import '../Constants/variables_constants.dart';
class SelectBranchWidget extends StatefulWidget {
  final bool spaceAroud;
  final Color textColor;
  String initialValue;
  SelectBranchWidget({this.spaceAroud,this.textColor,this.initialValue});
  var selectBranchWidgetState;
  @override
  _SelectBranchWidgetState createState() => selectBranchWidgetState=_SelectBranchWidgetState();
  getDropDownMenuValue()=>selectBranchWidgetState.dropDownValue;
}

class _SelectBranchWidgetState extends State<SelectBranchWidget> {
  String dropDownValue;
  Color textColor;
  @override
  void initState() {
    // TODO: implement initState
    textColor= widget.textColor==null?Colors.blue[900]:widget.textColor;
     dropDownValue=widget.initialValue==null?BRANCHES[0]:widget.initialValue;
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:widget.spaceAroud? MainAxisAlignment.spaceAround:MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Branch',
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
        ),
        DropdownButton(
          items: BRANCHES
              .map((e) => DropdownMenuItem<String>(
            child: Text(e),
            value: e,
          ))
              .toList(),
          value: dropDownValue,
          onChanged: (value) {
            setState(() {
              dropDownValue = value;
            });
          },
        ),
      ],
    );
  }
}
