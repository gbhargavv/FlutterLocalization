import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WidgetsUtils {
  Widget AddVerticalSpace(double height) {
    return SizedBox(
      height: height,
      width: 0,
    );
  }

  Widget AddHorizontalSpace(double width) {
    return SizedBox(
      height: 0,
      width: width,
    );
  }

  void showProgress(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(strokeWidth: 2, semanticsLabel: 'Appp'),
              AddHorizontalSpace(10),
              Container(
                  margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
            ],
          ),
        );
      },
    ).whenComplete(() => () {});
  }

  void hideProgress(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
