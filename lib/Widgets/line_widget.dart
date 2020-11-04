import 'package:bus_reservation_systerm/Models/line.dart';
import 'package:bus_reservation_systerm/Screens/line_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LineWidget extends StatelessWidget {
  Line lineModel;

  LineWidget(this.lineModel);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=>LineDetailsScreen(lineModel: lineModel,)
        ));
      },
      child: Card(
        elevation: 13,
        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(15.0)
        ),
        child: Container(

          padding: EdgeInsets.symmetric(horizontal: 10.0),
          height: screenSize.height * 0.2,
          // width: screenSize.width,
       
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.directions,
                      color: Color(0xFF03A9F4),
                      size: 40.0,
                    ),
                    Container(

                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Center(
                          child: Text(
                            '${lineModel.to}',
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .copyWith(color: Color(0xFF212121)),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
              ),
              Container(
               // color: Colors.blue,
                height: screenSize.height * 0.05,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[

                    ...lineModel.stations.map((e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: StationView(stationName: e),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StationView extends StatelessWidget {
  const StationView({
    Key key,
    @required this.stationName,
  }) : super(key: key);

  final String stationName;

  @override
  Widget build(BuildContext context) {
    return Container(

       padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 3.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(
              width: 2, color:Color(0xFF536DFE), style: BorderStyle.solid),
          color: Colors.white),
      child: Center(
        child: Text('$stationName',
            style: TextStyle(
              color:Color(0xFF212121),
              fontSize: 16,
              fontWeight: FontWeight.w700
            )),
      ),
    );
  }
}
