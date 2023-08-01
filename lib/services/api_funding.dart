import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:funsunfront/models/funding_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/api_account.dart';

class Funding {
  static const String baseUrl = "http://projectsekai.kro.kr:5000/funding/";
  static const storage = FlutterSecureStorage();

  static Future<FundingModel> getFunding(String id, int trigger) async {
    if (trigger == 0) {
      throw Error();
    }
    trigger -= 1;

    String? token = await storage.read(key: 'accessToken');
    final url = Uri.parse('$baseUrl?id=$id');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final funding = jsonDecode(response.body);
      return FundingModel.fromJson(funding);
    } else if (response.statusCode == 401) {
      await Account.refreshToken();
      return getFunding(id, trigger);
    }
    throw Error();
  }

  static Future<List<FundingModel>> getPublicFunding(String page) async {
    const token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkwOTA0Mjk0LCJpYXQiOjE2OTA4MTc4OTQsImp0aSI6IjFiN2I4MWJjY2E0YzQzYzY4MTFiMTkzN2VmMzRjY2ZhIiwiaWQiOiJhZG1pbiIsImlzX2FjdGl2ZSI6dHJ1ZX0.oeqBA5CucXfkjr2LEp1qO4OjRhDU4Ir0h_Jee29Od3o";
    final url = Uri.parse('${baseUrl}public?page=$page');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> fundingList = jsonDecode(response.body);
      return fundingList
          .map((funding) => FundingModel.fromJson(funding))
          .toList();
    }
    throw Error();
  }

  static Future<List<FundingModel>> getJoinedFunding(String page) async {
    const token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkwOTA0Mjk0LCJpYXQiOjE2OTA4MTc4OTQsImp0aSI6IjFiN2I4MWJjY2E0YzQzYzY4MTFiMTkzN2VmMzRjY2ZhIiwiaWQiOiJhZG1pbiIsImlzX2FjdGl2ZSI6dHJ1ZX0.oeqBA5CucXfkjr2LEp1qO4OjRhDU4Ir0h_Jee29Od3o";
    final url = Uri.parse('${baseUrl}joined?page=$page');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> fundingList = jsonDecode(response.body);
      return fundingList
          .map((funding) => FundingModel.fromJson(funding))
          .toList();
    }
    throw Error();
  }

  static Future<FundingModel> postFunding(var fundingData) async {
    String? token = await storage.read(key: 'accessToken');
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final url = Uri.parse(baseUrl);
    final response = await http.post(url, body: fundingData, headers: headers);
    if (response.statusCode == 201) {
      // Map<String, dynamic> resBodyJson = jsonDecode(response.body);

      return jsonDecode(response.body);
      // } else if (response.statusCode == 400) {
      //   return ;
      // }
      // return false;
    }
    throw Error();
  }
}
