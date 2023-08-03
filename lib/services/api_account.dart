import 'dart:convert';
import 'dart:io';
import 'package:funsunfront/models/account_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'kakao_login_api.dart';

class User {
  static const String baseUrl = "http://projectsekai.kro.kr:5000/account/";
  static const storage = FlutterSecureStorage();

  static Future<AccountModel> accessTokenLogin({int apiCounter = 2}) async {
    if (apiCounter == 0) {
      throw Error();
    }
    apiCounter -= 1;

    String? value = await storage.read(key: 'accessToken');
    if (value != null) {
      final header = {"Authorization": 'Bearer $value'};
      final response = await http.post(Uri.parse(baseUrl), headers: header);
      if (response.statusCode == 200) {
        final profile = jsonDecode(response.body);
        return AccountModel.fromJson(profile);
      } else if (response.statusCode == 401) {
        await refreshToken();
        return accessTokenLogin(apiCounter: apiCounter);
      } else if (response.statusCode == 500) {
        try {
          final token = await getKakaoToken();
          await getAllToken(token);
          return accessTokenLogin(apiCounter: apiCounter);
        } catch (e) {
          rethrow;
        }
      }
      throw Error();
    } else {
      final token = await getKakaoToken();
      await getAllToken(token);
      return accessTokenLogin(apiCounter: apiCounter);
    }
  }

  static Future<void> refreshToken() async {
    String? refreshToken = await storage.read(key: 'refreshToken');
    print(refreshToken);
    Map<String, String> body = {"refresh": refreshToken!};
    final response =
        await http.post(Uri.parse('${baseUrl}token/refresh'), body: body);
    print(response.body);
    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['access_token'];
      await storage.write(key: 'accessToken', value: token);
      return;
    } else if (response.statusCode == 401) {
      final token = await getKakaoToken();
      await getAllToken(token);
      return;
    }
  }

  static Future<void> getAllToken(String kakaotoken) async {
    final url = Uri.parse('${baseUrl}kakaologin');
    final body = {"accessToken": kakaotoken};
    final response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final accesstoken = jsonDecode(response.body)['token']['access_token'];
      final refreshtoken = jsonDecode(response.body)['token']['refresh_token'];
      await storage.write(key: 'accessToken', value: accesstoken);
      await storage.write(key: 'refreshToken', value: refreshtoken);
    }
  }

  static Future<AccountModel> getProfile(
      {required String uid, int apiCounter = 2}) async {
    if (apiCounter == 0) {
      throw Error();
    }
    apiCounter -= 1;
    String? token = await storage.read(key: 'accessToken');
    final url = Uri.parse('$baseUrl?id=$uid');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final profile = jsonDecode(response.body);
      return AccountModel.fromJson(profile);
    } else if (response.statusCode == 401) {
      await refreshToken();
      return getProfile(uid: uid, apiCounter: apiCounter);
    }
    throw Error();
  }

  static Future<List<AccountModel>> userSearch(
      {required String username, int apiCounter = 2}) async {
    if (apiCounter == 0) {
      throw Error();
    }
    apiCounter -= 1;
    String? token = await storage.read(key: 'accessToken');
    final url = Uri.parse('${baseUrl}search?username=$username');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> searchedUsers = jsonDecode(response.body);
      return searchedUsers.map((user) => AccountModel.fromJson(user)).toList();
    } else if (response.statusCode == 401) {
      await refreshToken();
      return userSearch(username: username, apiCounter: apiCounter);
    }
    throw Error();
  }

  static Future<Map<String, dynamic>> putUser(
      {required Map<String, dynamic> userData,
      File? image,
      int apiCounter = 2}) async {
    if (apiCounter == 0) {
      throw Error();
    }
    apiCounter -= 1;
    String? token = await storage.read(key: 'accessToken');
    final headers = {'Authorization': 'Bearer $token'};
    final url = Uri.parse(baseUrl);
    final req = http.MultipartRequest('PUT', url);
    req.headers.addAll(headers);
    req.fields['id'] = userData['id'];
    req.fields['email'] = userData['email'];
    req.fields['birthday'] = userData['birthday'];
    req.fields['gender'] = userData['gender'];

    if (image != null) {
      req.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    final response0 = await req.send();
    final response = await http.Response.fromStream(response0);
    if (response.statusCode == 201) {
      Map<String, dynamic> resBodyJson = jsonDecode(response.body);

      return resBodyJson;
    } else if (response.statusCode == 401) {
      await User.refreshToken();
      putUser(userData: userData, image: image, apiCounter: apiCounter);
    }

    throw Error();
  }
}
