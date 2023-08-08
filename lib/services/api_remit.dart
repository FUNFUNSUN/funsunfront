import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funsunfront/models/remit_model.dart';
import 'package:http/http.dart' as http;

import 'api_account.dart';

class Remit {
  static const String baseUrl = "http://projectsekai.kro.kr:5000/remit/";
  static const storage = FlutterSecureStorage();

  static Future<List<RemitModel>> getRemit(
      {required String id, required String page, int apiCounter = 2}) async {
    if (apiCounter == 0) {
      throw Error();
    }
    apiCounter -= 1;
    final url = Uri.parse('$baseUrl?id=$id&page=$page');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> remitList = jsonDecode(response.body);
      return remitList.map((remit) => RemitModel.fromJson(remit)).toList();
    } else if (response.statusCode == 401) {
      await User.refreshToken();
      getRemit(id: id, page: page, apiCounter: apiCounter);
    } else if (response.statusCode == 204) {
      return List.empty();
    }
    throw Error();
  }

  static Future<bool> postRemit(
      {required String remitData, int trigger = 2}) async {
    if (trigger == 0) {
      throw Error();
    }
    trigger -= 1;
    String? token = await storage.read(key: 'accessToken');
    final url = Uri.parse(baseUrl);
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final response = await http.post(url, headers: headers, body: remitData);
    print(response.statusCode);
    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 401) {
      await User.refreshToken();
      return postRemit(remitData: remitData);
    }
    return false;
  }

  static Future<String> getPayRedirect(
      {required int amount, required String userid, int trigger = 2}) async {
    if (trigger == 0) {
      throw Error();
    }
    trigger -= 1;
    String? token = await storage.read(key: 'accessToken');
    final headers = {'Authorization': 'Bearer $token'};
    final url = Uri.parse('${baseUrl}kakaopay/ready');
    final response = await http
        .post(url, headers: headers, body: {'amount': amount.toString()});
    if (response.statusCode == 200) {
      final redirect = jsonDecode(response.body);
      return redirect['url'];
    } else if (response.statusCode == 401) {
      await User.refreshToken();
      return getPayRedirect(amount: amount, userid: userid);
    }
    throw Error();
  }

  static Future<bool> postPayApprove(
      {required String userid,
      required String pgToken,
      int trigger = 2}) async {
    if (trigger == 0) {
      throw Error();
    }
    trigger -= 1;
    String? token = await storage.read(key: 'accessToken');
    final headers = {'Authorization': 'Bearer $token'};
    final url = Uri.parse('${baseUrl}kakaopay/approve');
    final response =
        await http.post(url, headers: headers, body: {'pg_token': pgToken});
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      await User.refreshToken();
      return postPayApprove(userid: userid, pgToken: pgToken);
    }
    return false;
  }

  static Future<bool> getPayApprove({int trigger = 2}) async {
    if (trigger == 0) {
      throw Error();
    }
    trigger -= 1;
    String? token = await storage.read(key: 'accessToken');
    final headers = {'Authorization': 'Bearer $token'};
    final url = Uri.parse('${baseUrl}kakaopay/approve');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      await User.refreshToken();
      return getPayApprove();
    }
    return false;
  }
}
