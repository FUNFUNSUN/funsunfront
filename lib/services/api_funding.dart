import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:funsunfront/models/funding_model.dart';

class Funding {
  static const String baseUrl = "http://projectsekai.kro.kr:5000/funding/";

  static Future<FundingModel> getFunding(String id) async {
    const token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkwODY4MTAwLCJpYXQiOjE2OTA3ODE3MDAsImp0aSI6ImVlMjVlNzRkNDU4YjRjN2E5OGFjMDRlZmRjZTZhNzM3IiwiaWQiOiJhZG1pbiIsImlzX2FjdGl2ZSI6dHJ1ZX0.1Nl5hagpBn7FkqJorMFSK-XItE1rNICqX8J0co2MSK0";
    final url = Uri.parse('$baseUrl?id=$id');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final funding = jsonDecode(response.body);
      return FundingModel.fromJson(funding);
    }
    throw Error();
  }

  static Future<List<FundingModel>> getPublicFunding(String page) async {
    const token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkwODY4MTAwLCJpYXQiOjE2OTA3ODE3MDAsImp0aSI6ImVlMjVlNzRkNDU4YjRjN2E5OGFjMDRlZmRjZTZhNzM3IiwiaWQiOiJhZG1pbiIsImlzX2FjdGl2ZSI6dHJ1ZX0.1Nl5hagpBn7FkqJorMFSK-XItE1rNICqX8J0co2MSK0";
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
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkwODY4MTAwLCJpYXQiOjE2OTA3ODE3MDAsImp0aSI6ImVlMjVlNzRkNDU4YjRjN2E5OGFjMDRlZmRjZTZhNzM3IiwiaWQiOiJhZG1pbiIsImlzX2FjdGl2ZSI6dHJ1ZX0.1Nl5hagpBn7FkqJorMFSK-XItE1rNICqX8J0co2MSK0";
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
}
