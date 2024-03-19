import 'dart:async';
import 'package:ceramic_story/utils/localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MainScreen())));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Image.asset('assets/images/ic_icon.png', height: 100),
        ),
      ),
    );
  }
}
