import 'dart:convert';
import 'package:funsunfront/models/remit_model.dart';
import 'package:http/http.dart' as http;

class Remit {
  static const String baseUrl = "http://projectsekai.kro.kr:5000/remit/";

  static Future<List<RemitModel>> getRemit(String id, String page) async {
    const token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkwNzIzMjQ4LCJpYXQiOjE2OTA2MzY4NDgsImp0aSI6IjdkNjAwZWYxMjM0ZDRhZGZhZDYxZjA3NTJmMWY3ZjQ4IiwiaWQiOiJhZG1pbiIsImlzX2FjdGl2ZSI6dHJ1ZX0.AvJLZmw2eiv7XQFkCxuyUQD7_5CM8wIBAMuJ0qkMFEI";
    final url = Uri.parse('$baseUrl?id=$id&page=$page');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> remitList = jsonDecode(response.body);
      return remitList.map((remit) => RemitModel.fromJson(remit)).toList();
    }
    throw Error();
  }
}
