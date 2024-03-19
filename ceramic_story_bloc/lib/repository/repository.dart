import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/company_story.dart';
import '../model/company_story_line.dart';
import '../utils/api_constant.dart';

class Repository {
  Future<List<CompanyStory>> getCompanyStory() async {
    Map<String, String> body = {ApiConstant.API_KEY: ApiConstant.API_KEY_VALUE};

    var response = await http.post(
      Uri.parse(ApiConstant.BASE_URL + ApiConstant.COMPANY_STORY),
      body: body,
    );

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)[ApiConstant.SUCCESS].toString().compareTo('1') == 0) {
        final List result = jsonDecode(response.body)[ApiConstant.RESPONSE]['company_storyline_list'];
        return result.map((e) => CompanyStory.fromJson(e)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<CompanyStoryLine>> getCompanyStoryLine(
      String companyStoryId) async {
    Map<String, String> body = {
      ApiConstant.API_KEY: ApiConstant.API_KEY_VALUE,
      ApiConstant.COM_STORY_ID: companyStoryId
    };

    var response = await http.post(
      Uri.parse(ApiConstant.BASE_URL + ApiConstant.COMPANY_STORY_LINE),
      body: body,
    );

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)[ApiConstant.SUCCESS].toString().compareTo('1') == 0) {
        final List result = jsonDecode(response.body)[ApiConstant.RESPONSE]['company_storyline_list'];
        return result.map((e) => CompanyStoryLine.fromJson(e)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
