import 'dart:convert';
import 'dart:io';
import 'package:cpico_pro/model/StoreResponse.dart';
import 'package:cpico_pro/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/ApiHelper.dart';
import '../utils/Status.dart';

class ProductSearchLinkViewModel extends ChangeNotifier {
  late StoreResponse storeModel;
  Status login_status = Status.NULL;
  String productLink = '';

  void clearStatus() {
    login_status = Status.NULL;
  }

  Future<void> getProductLink(String id) async {
    try {
      login_status = Status.LOADING;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(Constant.TOKEN);
      http.Response response = await ApiHelper()
          .getProductSearchLink(id, token.toString()) as http.Response;
      if (response.statusCode == 200) {
        var results = json.decode(response.body);
        if (results['code'].toString().compareTo('200') == 0 &&
            results['data'] != null) {
          List<dynamic> _data = <dynamic>[];
          results['data'].forEach((v) {
            _data.add(v);
          });
          if (_data[0]['link'].toString().length > 0) {
            productLink = _data[0]['link'].toString();
            login_status = Status.SUCCESS;
            notifyListeners();
          } else {
            login_status = Status.ERROR;
            notifyListeners();
          }
        } else if (results['code'].toString().compareTo('407') == 0) {
          login_status = Status.LOGOUT;
          notifyListeners();
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
