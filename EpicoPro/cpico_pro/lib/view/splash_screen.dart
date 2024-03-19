import 'dart:async';

import 'package:cpico_pro/utils/ApiConstant.dart';
import 'package:cpico_pro/utils/constant.dart';
import 'package:cpico_pro/view/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    !ApiConstant.token.toString().contains(null.toString()) &&
                            ApiConstant.token.length > 0
                        ? HomeScreen()
                        : LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Colors.brown,
        child: Center(
          child: Text(
            'Epico Pro',
            style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }
}
