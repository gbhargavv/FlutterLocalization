import 'dart:collection';
import 'dart:convert';

import 'package:cpico_pro/model/StoreResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ApiConstant.dart';
import 'package:http/http.dart' as http;

import 'constant.dart';

class ApiHelper {
  String basicAuth = 'Basic ' +
      base64.encode(utf8.encode('app_ep_user:AvjgkfjtrfrD5ertgyQikujo9'));

  Future<http.Response> login(String login_type, String user_name,
      String password, String store_id) async {
    var map = new Map<String, dynamic>();
    map['login_type'] = login_type;
    map['customer_login_user'] = user_name;
    map['customer_login_password'] = password;
    map['mobile_os'] = "A";
    map['push_notification_id'] = "1231313231231232131231212";
    map['app_version'] = "1.0";
    map['os_version'] = "";
    map['model_info'] = "";
    map['store_id'] = "";

    final response = await http.post(
        Uri.parse(ApiConstant.BASE_URL + ApiConstant.login),
        body: map,
        headers: <String, String>{'authorization': basicAuth});
    print("-------- response : " + response.body.toString());
    return response;
  }

  Future<http.Response> getStores() async {
    final response = await http.post(
        Uri.parse(ApiConstant.BASE_URL + ApiConstant.stores),
        headers: <String, String>{'authorization': basicAuth});
    print("-------- response : " + response.body.toString());
    return response;
  }

  Future<http.Response> getProductSearchLink(
      String product_id, String token) async {
    var map = new Map<String, dynamic>();
    map['api_token'] = token;
    map['product_id'] = product_id;

    final response = await http.post(
        Uri.parse(ApiConstant.BASE_URL + ApiConstant.product_search_link),
        body: map,
        headers: <String, String>{'authorization': basicAuth});
    print("-------- response : " + response.body.toString());
    return response;
  }

  Future<http.Response> sas(String type) async {
    final response = await http.get(
        Uri.parse(ApiConstant.BASE_URL +
            ApiConstant.BASE_URL +
            "type=" +
            type +
            "&video=1"),
        headers: {'APIKEY': 'AAi985fy988fsdkjfjhdsfkj78FSQPld8d'});
    return response;
  }

  Future<http.Response> fetchHomeData(String type) async {
    final response = await http.get(
        Uri.parse(ApiConstant.BASE_URL +
            ApiConstant.BASE_URL +
            "type=" +
            type +
            "&video=1"),
        headers: {'APIKEY': 'AAi985fy988fsdkjfjhdsfkj78FSQPld8d'});
    return response;
  }

  Future<http.Response> fetchLanguageData() async {
    final response = await http.get(
        Uri.parse(ApiConstant.BASE_URL + ApiConstant.BASE_URL),
        headers: {'APIKEY': 'AAi985fy988fsdkjfjhdsfkj78FSQPld8d'});
    return response;
  }

  Future<http.Response> fetchImageList(
      String type, String video, String category) async {
    final response = await http.get(
        Uri.parse(ApiConstant.BASE_URL +
            ApiConstant.BASE_URL +
            "?type=+" +
            type +
            "&video=" +
            video +
            "&category=" +
            category),
        headers: {'APIKEY': 'AAi985fy988fsdkjfjhdsfkj78FSQPld8d'});
    return response;
  }
}
