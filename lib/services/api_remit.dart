import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funsunfront/models/remit_model.dart';
import 'package:http/http.dart' as http;

import 'api_account.dart';

class Remit {
  static const String baseUrl = "http://projectsekai.kro.kr:5000/remit/";
  static const storage = FlutterSecureStorage();

  static Future<List<RemitModel>> getRemit(
      String id, String page, int trigger) async {
    if (trigger == 0) {
      throw Error();
    }
    trigger -= 1;
    final url = Uri.parse('$baseUrl?id=$id&page=$page');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> remitList = jsonDecode(response.body);
      return remitList.map((remit) => RemitModel.fromJson(remit)).toList();
    } else if (response.statusCode == 401) {
      await Account.refreshToken();
      getRemit(id, page, trigger);
    }
    throw Error();
  }
}
