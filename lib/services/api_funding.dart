import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:funsunfront/models/funding_model.dart';
import 'package:intl/intl.dart';

import 'api_account.dart';

class Funding {
  static const String baseUrl = "http://projectsekai.kro.kr:5000/funding/";
  static const storage = FlutterSecureStorage();

  static Future<FundingModel> getFunding(
      {required String id, int trigger = 2}) async {
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
      getFunding(id: id, trigger: trigger);
    }
    throw Error();
  }

  static Future<List<FundingModel>> getPublicFunding(
      {required String page, int trigger = 2}) async {
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
      getPublicFunding(page: page, trigger: trigger);
    }
    throw Error();
  }

  static Future<List<FundingModel>> getUserFunding(
      {required String page, required String id, int trigger = 2}) async {
    if (trigger == 0) {
      throw Error();
    }
    trigger -= 1;

    String? token = await storage.read(key: 'accessToken');
    final url = Uri.parse('${baseUrl}user?page=$page&id=$id');
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
      getUserFunding(page: page, id: id, trigger: trigger);
    }
    throw Error();
  }

  static Future<List<FundingModel>> getJoinedFunding(
      {required String page, int trigger = 2}) async {
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
      getJoinedFunding(page: page, trigger: trigger);
    }
    throw Error();
  }

  static Future<Map<String, dynamic>> postFunding(
      {required Map<String, dynamic> fundingData,
      File? image,
      int trigger = 2}) async {
    if (trigger == 0) {
      throw Error();
    }
    trigger -= 1;
    String? token = await storage.read(key: 'accessToken');
    final headers = {'Authorization': 'Bearer $token'};
    final url = Uri.parse(baseUrl);
    final req = http.MultipartRequest('POST', url);
    req.headers.addAll(headers);
    req.fields['title'] = fundingData['title'];
    req.fields['content'] = fundingData['content'];
    req.fields['goal_amount'] = fundingData['goal_amount'];

    req.fields['public'] = jsonEncode(fundingData['public']);
    if (fundingData['expire_on'].runtimeType == DateTime) {
      req.fields['expire_on'] =
          DateFormat('yyyy-MM-dd').format(fundingData['expire_on']);
    }
    if (image != null) {
      req.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    final response0 = await req.send();
    final response = await http.Response.fromStream(response0);
    if (response.statusCode == 201) {
      Map<String, dynamic> resBodyJson = jsonDecode(response.body);

      return resBodyJson;
    } else if (response.statusCode == 401) {
      await Account.refreshToken();
      postFunding(fundingData: fundingData, image: image, trigger: trigger);
    }
    print(response.body);
    throw Error();
  }
}
