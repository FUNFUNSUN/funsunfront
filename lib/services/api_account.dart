import 'dart:convert';
import 'package:funsunfront/models/account_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'kakao_login_api.dart';

class Account {
  static const String baseUrl = "http://projectsekai.kro.kr:5000/account/";
  static const storage = FlutterSecureStorage();

  static Future<AccountModel> accessTokenLogin() async {
    String? value = await storage.read(key: 'accessToken');
    if (value != null) {
      final header = {"Authorization": 'Bearer $value'};
      final response = await http.post(Uri.parse(baseUrl), headers: header);
      if (response.statusCode == 200) {
        final profile = jsonDecode(response.body);
        return AccountModel.fromJson(profile);
      } else if (response.statusCode == 401) {
        return refreshTokenLogin();
      }
      throw Error();
    } else {
      String kakaotoken = await getKakaoToken();
      return kakaoLogin(kakaotoken);
    }
  }

  static Future<AccountModel> refreshTokenLogin() async {
    String? refreshToken = await storage.read(key: 'refreshToken');
    final response = await http.post(Uri.parse('${baseUrl}token/refresh'),
        body: refreshToken);
    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['access'];
      await storage.write(key: 'accessToken', value: token);
      final header = {"Authorization": 'Bearer $token'};
      final accountres = await http.post(Uri.parse(baseUrl), headers: header);
      if (accountres.statusCode == 200) {
        final profile = jsonDecode(response.body);
        return AccountModel.fromJson(profile);
      }
    } else if (response.statusCode == 401) {
      String kakaotoken = await getKakaoToken();
      return kakaoLogin(kakaotoken);
    }
    throw Error();
  }

  static Future<AccountModel> kakaoLogin(String kakaotoken) async {
    final url = Uri.parse('${baseUrl}kakaologin');
    final body = {"accessToken": kakaotoken};
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final user = jsonDecode(response.body)['user'];
      final accesstoken = jsonDecode(response.body)['token']['access_token'];
      final refreshtoken = jsonDecode(response.body)['token']['refresh_token'];
      await storage.write(key: 'accessToken', value: accesstoken);
      await storage.write(key: 'refreshToken', value: refreshtoken);
      final profile = AccountModel.fromJson(user);
      return profile;
    }
    throw Error();
  }

  static Future<AccountModel> getProfile(String uid) async {
    // 토큰 테스트
    const token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkwNzIzMjQ4LCJpYXQiOjE2OTA2MzY4NDgsImp0aSI6IjdkNjAwZWYxMjM0ZDRhZGZhZDYxZjA3NTJmMWY3ZjQ4IiwiaWQiOiJhZG1pbiIsImlzX2FjdGl2ZSI6dHJ1ZX0.AvJLZmw2eiv7XQFkCxuyUQD7_5CM8wIBAMuJ0qkMFEI";
    final url = Uri.parse('$baseUrl?id=$uid');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final profile = jsonDecode(response.body);
      return AccountModel.fromJson(profile);
    }
    throw Error();
  }
}
