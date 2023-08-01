import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:funsunfront/models/funding_model.dart';

import 'api_account.dart';

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
    }
    throw Error();
  }

  static Future<List<FundingModel>> getPublicFunding(
      String page, int trigger) async {
    if (trigger == 0) {
      throw Error();
    }
    trigger -= 1;
    String? token = await storage.read(key: 'accessToken');
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
    } else if (response.statusCode == 401) {
      await Account.refreshToken();
    }
    throw Error();
  }

  static Future<List<FundingModel>> getUserFunding(
      String page, String id, int trigger) async {
    if (trigger == 0) {
      throw Error();
    }
    trigger -= 1;

    String? token = await storage.read(key: 'accessToken');
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
    } else if (response.statusCode == 401) {
      await Account.refreshToken();
    }
    throw Error();
  }

  static Future<List<FundingModel>> getJoinedFunding(
      String page, int trigger) async {
    if (trigger == 0) {
      throw Error();
    }
    trigger -= 1;
    String? token = await storage.read(key: 'accessToken');
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
    } else if (response.statusCode == 401) {
      await Account.refreshToken();
    }
    throw Error();
  }

  static Future<bool> postFunding(
      Map<String, dynamic> fundingData, int trigger) async {
    if (trigger == 0) {
      throw Error();
    }
    trigger -= 1;
    String? token = await storage.read(key: 'accessToken');
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final url = Uri.parse(baseUrl);
    final response = await http.post(url, body: fundingData, headers: headers);
    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 401) {
      await Account.refreshToken();
      return false;
    }
    return false;
  }
}
