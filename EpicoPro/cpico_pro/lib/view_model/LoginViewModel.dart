import 'dart:convert';
import 'dart:io';
import 'package:cpico_pro/model/StoreResponse.dart';
import 'package:cpico_pro/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/ApiHelper.dart';
import '../utils/Status.dart';

class LoginViewModel extends ChangeNotifier {
  late StoreResponse storeModel;
  Status login_status = Status.NULL;

  void clearStatus() {
    login_status = Status.NULL;
  }

  Future<void> login(String login_type, String user_name, String password,
      String store_id) async {
    try {
      login_status = Status.LOADING;
      notifyListeners();
      http.Response response = await ApiHelper()
          .login(login_type, user_name, password, store_id) as http.Response;
      if (response.statusCode == 200) {
        var results = json.decode(response.body);
        if (results['data'] != null) {
          List<dynamic> _data = <dynamic>[];
          results['data'].forEach((v) {
            _data.add(v);
          });
          if (_data[0]['api_token'].toString().length > 0) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString(Constant.TOKEN, _data[0]['api_token'].toString());
            login_status = Status.SUCCESS;
            notifyListeners();
          } else {
            login_status = Status.ERROR;
            notifyListeners();
          }
          print('------ token : ' + _data[0]['api_token'].toString());
        } else {
          login_status = Status.ERROR;
          notifyListeners();
        }
      } else {
        login_status = Status.ERROR;
        notifyListeners();
      }
    } on SocketException {
      login_status = Status.NO_INTERNET_CONNECTION;
      notifyListeners();
    }
  }
}
