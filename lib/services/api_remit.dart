import 'dart:convert';
import 'package:funsunfront/models/remit_model.dart';
import 'package:http/http.dart' as http;

class Remit {
  static const String baseUrl = "http://projectsekai.kro.kr:5000/remit/";

  static Future<List<RemitModel>> getRemit(String id, String page) async {
    final url = Uri.parse('$baseUrl?id=$id&page=$page');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> remitList = jsonDecode(response.body);
      return remitList.map((remit) => RemitModel.fromJson(remit)).toList();
    }
    throw Error();
  }
}
