import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:funsunfront/models/funding_model.dart';

import 'api_account.dart';

class Funding {
  static const String baseUrl = "http://projectsekai.kro.kr:5000/funding/";
  static const storage = FlutterSecureStorage();

  static Future<FundingModel> getFunding(
      {required String id, int apiCounter = 2}) async {
    if (apiCounter == 0) {
      throw Error();
    }
    apiCounter -= 1;
    String? token = await storage.read(key: 'accessToken');
    final url = Uri.parse('$baseUrl?id=$id');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final funding = jsonDecode(response.body);
      return FundingModel.fromJson(funding);
    } else if (response.statusCode == 401) {
      await User.refreshToken();
      getFunding(id: id, apiCounter: apiCounter);
    }
    throw Error();
  }

  static Future<List<FundingModel>> getPublicFunding(
      {required String page, int apiCounter = 2}) async {
    if (apiCounter == 0) {
      throw Error();
    }
    apiCounter -= 1;
    String? token = await storage.read(key: 'accessToken');
    final url = Uri.parse('${baseUrl}public?page=$page');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> fundingList = jsonDecode(response.body);
      return fundingList
          .map((funding) => FundingModel.fromJson(funding))
          .toList();
    } else if (response.statusCode == 204) {
      return [];
    } else if (response.statusCode == 401) {
      await User.refreshToken();
      getPublicFunding(page: page, apiCounter: apiCounter);
    }
    throw Error();
  }

  static Future<List<FundingModel>> getFriendFunding(
      {required String page, int apiCounter = 2}) async {
    if (apiCounter == 0) {
      throw Error();
    }
    apiCounter -= 1;
    String? token = await storage.read(key: 'accessToken');

    final url = Uri.parse('${baseUrl}following?page=$page');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> fundingList = jsonDecode(response.body);
      return fundingList
          .map((funding) => FundingModel.fromJson(funding))
          .toList();
    } else if (response.statusCode == 204) {
      return [];
    } else if (response.statusCode == 401) {
      await User.refreshToken();
      getFriendFunding(page: page, apiCounter: apiCounter);
    }
    throw Error();
  }

  static Future<List<FundingModel>> getUserFunding(
      {required String page, required String id, int apiCounter = 2}) async {
    if (apiCounter == 0) {
      throw Error();
    }
    apiCounter -= 1;

    String? token = await storage.read(key: 'accessToken');
    final url = Uri.parse('${baseUrl}user?page=$page&id=$id');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> fundingList = jsonDecode(response.body);
      return fundingList
          .map((funding) => FundingModel.fromJson(funding))
          .toList();
    } else if (response.statusCode == 204) {
      return [];
    } else if (response.statusCode == 401) {
      await User.refreshToken();
      getUserFunding(page: page, id: id, apiCounter: apiCounter);
    }
    throw Error();
  }

  static Future<List<FundingModel>> getJoinedFunding(
      {required String page, int apiCounter = 2}) async {
    if (apiCounter == 0) {
      throw Error();
    }
    apiCounter -= 1;
    String? token = await storage.read(key: 'accessToken');
    final url = Uri.parse('${baseUrl}joined?page=$page');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> fundingList = jsonDecode(response.body);
      return fundingList
          .map((funding) => FundingModel.fromJson(funding))
          .toList();
    } else if (response.statusCode == 204) {
      return [];
    } else if (response.statusCode == 401) {
      await User.refreshToken();
      getJoinedFunding(page: page, apiCounter: apiCounter);
    }
    throw Error();
  }

  static Future<Map<String, dynamic>> postFunding(
      {required Map<String, dynamic> fundingData,
      File? image,
      int apiCounter = 2}) async {
    if (apiCounter == 0) {
      throw Error();
    }
    apiCounter -= 1;
    String? token = await storage.read(key: 'accessToken');
    final headers = {'Authorization': 'Bearer $token'};
    final url = Uri.parse(baseUrl);
    final req = http.MultipartRequest('POST', url);
    req.headers.addAll(headers);
    req.fields['title'] = fundingData['title'];
    req.fields['content'] = fundingData['content'];
    req.fields['goal_amount'] = fundingData['goal_amount'];
    req.fields['public'] = jsonEncode(fundingData['public']);
    req.fields['expire_on'] = fundingData['expire_on'];

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
      postFunding(
          fundingData: fundingData, image: image, apiCounter: apiCounter);
    }
    print(response.body);
    throw Error();
  }

  static Future<Map<String, dynamic>> putFunding(
      {required Map<String, dynamic> editData,
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
    req.fields['id'] = editData['id'];
    req.fields['title'] = editData['title'];
    req.fields['content'] = editData['content'];
    req.fields['public'] = jsonEncode(editData['public']);
    req.fields['image_delete'] = editData['image_delete'];

    if (image != null) {
      req.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    final response0 = await req.send();
    final response = await http.Response.fromStream(response0);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> resBodyJson = jsonDecode(response.body);
      print(resBodyJson);
      return resBodyJson;
    } else if (response.statusCode == 401) {
      await User.refreshToken();
      putFunding(editData: editData, image: image, apiCounter: apiCounter);
    }
    print(response.body);
    throw Error();
  }

  static Future<Map<String, dynamic>> putReview(
      {required Map<String, dynamic> editData,
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
    req.fields['id'] = editData['id'];
    req.fields['review'] = editData['review'];
    // req.fields['image_delete'] = editData['image_delete'];

    if (image != null) {
      req.files
          .add(await http.MultipartFile.fromPath('review_image', image.path));
    }

    final response0 = await req.send();
    final response = await http.Response.fromStream(response0);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> resBodyJson = jsonDecode(response.body);

      return resBodyJson;
    } else if (response.statusCode == 401) {
      await User.refreshToken();
      putReview(editData: editData, image: image, apiCounter: apiCounter);
    }
    print(response.body);
    throw Error();
  }

  static Future<bool> deleteFunding(
      {required String id, int apiCounter = 2}) async {
    if (apiCounter == 0) {
      throw Error();
    }
    apiCounter -= 1;
    String? token = await storage.read(key: 'accessToken');
    final headers = {'Authorization': 'Bearer $token'};
    final url = Uri.parse(baseUrl);

    final response = await http.delete(url, headers: headers, body: {'id': id});
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      await User.refreshToken();
      return deleteFunding(id: id);
    }
    return false;
  }
}
