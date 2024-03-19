import 'dart:ffi';

import 'package:internet_connection_checker/internet_connection_checker.dart';

class Utils {
  Future<bool> checkInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      return true;
    } else {
      print('No internet :( Reason:');
      return false;
    }
  }
}
