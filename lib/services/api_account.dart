import 'dart:convert';
import 'package:funsunfront/models/account_model.dart';
import 'package:http/http.dart' as http;

class Account {
  static const String baseUrl = "http://projectsekai.kro.kr:5000/account/";

  static Future<AccountModel> getProfile(String uid) async {
    final url = Uri.parse('$baseUrl?id=$uid');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final profile = jsonDecode(response.body);
      return AccountModel.fromJson(profile);
    }
    throw Error();
  }
}
