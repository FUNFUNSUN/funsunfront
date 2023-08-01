import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funsunfront/services/api_account.dart';

class Follow {
  static const String baseUrl = "http://projectsekai.kro.kr:5000/follow/";
  static const storage = FlutterSecureStorage();

  static Future<bool> isFollowing(
      {required String uid,
      required String currentuid,
      int apiCounter = 2}) async {
    if (apiCounter == 0) {
      throw Error();
    }
    apiCounter -= 1;
    String? token = await storage.read(key: 'accessToken');
    final url = Uri.parse('$baseUrl?follower=$currentuid&followee=$uid');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      print(res);
      return res['detail'];
    } else if (response.statusCode == 401) {
      await User.refreshToken();
      return postFollow(uid: uid);
    }
    return false;
  }

  static Future<bool> postFollow(
      {required String uid, int apiCounter = 2}) async {
    if (apiCounter == 0) {
      throw Error();
    }
    apiCounter -= 1;

    String? token = await storage.read(key: 'accessToken');
    final url = Uri.parse(baseUrl);
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(url, headers: headers, body: {'id': uid});
    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 401) {
      await User.refreshToken();
      return postFollow(uid: uid);
    }
    return false;
  }

  static Future<bool> delFollow(
      {required String uid, int apiCounter = 2}) async {
    if (apiCounter == 0) {
      throw Error();
    }
    apiCounter -= 1;

    String? token = await storage.read(key: 'accessToken');
    final url = Uri.parse(baseUrl);
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response =
        await http.delete(url, headers: headers, body: {'id': uid});
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      await User.refreshToken();
      return postFollow(uid: uid);
    }
    return false;
  }
}
