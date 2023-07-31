import 'dart:convert';
import 'package:funsunfront/models/remit_model.dart';
import 'package:http/http.dart' as http;

class Remit {
  static const String baseUrl = "http://projectsekai.kro.kr:5000/remit/";

  static Future<List<RemitModel>> getRemit(String id, String page) async {
    const token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkwOTA0Mjk0LCJpYXQiOjE2OTA4MTc4OTQsImp0aSI6IjFiN2I4MWJjY2E0YzQzYzY4MTFiMTkzN2VmMzRjY2ZhIiwiaWQiOiJhZG1pbiIsImlzX2FjdGl2ZSI6dHJ1ZX0.oeqBA5CucXfkjr2LEp1qO4OjRhDU4Ir0h_Jee29Od3o";
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
