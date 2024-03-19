import 'dart:convert';
import 'dart:io';
import 'package:cpico_pro/model/StoreResponse.dart';
import 'package:cpico_pro/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/ApiHelper.dart';
import '../utils/Status.dart';

class StoreViewModel extends ChangeNotifier {
  late StoreResponse storeModel;
  Status status = Status.NULL;

  void clearStatus() {
    status = Status.NULL;
  }

  Future<void> getStoreData() async {
    try {
      status = Status.LOADING;
      notifyListeners();
      http.Response response = await ApiHelper().getStores() as http.Response;
      if (response.statusCode == 200) {
        var results = json.decode(response.body);
        this.storeModel = StoreResponse.fromJson(results);
        status = Status.SUCCESS;
        notifyListeners();
      } else {
        status = Status.ERROR;
        notifyListeners();
      }
    } on SocketException {
      status = Status.NO_INTERNET_CONNECTION;
      notifyListeners();
    }
  }
}
