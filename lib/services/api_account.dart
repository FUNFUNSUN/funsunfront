import 'dart:convert';
import 'package:funsunfront/models/account_model.dart';
import 'package:http/http.dart' as http;

class Account {
  static const String baseUrl = "http://projectsekai.kro.kr:5000/account";

  static Future<AccountModel> getProfile(String uid) async {
    // 토큰 테스트
    const token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkwNzI1MjUzLCJpYXQiOjE2OTA2Mzg4NTMsImp0aSI6IjNlODliMGFlOTA3NjRlNWRiNjI3ZTlhMDgwZmY3ZDkzIiwiaWQiOiJhZG1pbiIsImlzX2FjdGl2ZSI6dHJ1ZX0.CpHtzLxaTO0S_KNgEV-3VVL0wBZzaq7gqEDZ_Y9yawE";
    final url = Uri.parse('$baseUrl/?id=$uid');
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
