import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
class LoadingTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 200,
                child: Image.asset('assets/eva_pharma_logo.jpg'),
              ),
              showLoadingText(),
            ]),
      ),
    );
  }
  SizedBox showLoadingText() {
    return SizedBox(
      width: 250.0,
      child: TypewriterAnimatedTextKit(
        text: ["Loading...", "Please wait..."],
        textStyle: TextStyle(
          fontSize: 30.0,
          color: Colors.blue[900],
        ),
        textAlign: TextAlign.center,
        alignment: AlignmentDirectional.topStart,
        repeatForever: true,
        //
        speed: Duration(milliseconds: 100), // or Alignment.topLeft
      ),
    );
  }
}
