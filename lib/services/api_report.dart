import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import 'api_account.dart';

class Report {
  static const String baseUrl = "http://projectsekai.kro.kr:5000/report/";
  static const storage = FlutterSecureStorage();

  static Future<bool> postReport(
      {required String reportData, int trigger = 2}) async {
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

    final response = await http.post(url, headers: headers, body: reportData);
    print(response.statusCode);
    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 401) {
      await User.refreshToken();
      postReport(reportData: reportData);
    }
    return false;
  }
}
