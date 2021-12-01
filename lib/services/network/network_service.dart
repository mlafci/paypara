import 'dart:convert';
import 'package:paypara/core/constants/network_constant.dart';
import 'package:http/http.dart';

class NetworkService {
  static Future<dynamic> requsetGet({
    String path,
    Map<String, dynamic> data,
  }) async {
    Uri url = Uri.https(NetworkConstants.baseUrl, path, data);
    Response response = await get(
      url,
      headers: {
        "Content-Type": "application/json",
        //"Authorization": 'Bearer <token>',
      },
    );
    return response;
  }

  static Future<dynamic> requsetPost({
    String path,
    Map<String, dynamic> data,
  }) async {
    Uri url = Uri.https(NetworkConstants.baseUrl, path, data);
    Response response = await post(
      url,
      body: jsonEncode(data),
      headers: {
        "Content-Type": "application/json",
        //"Authorization": 'Bearer <token>',
      },
    );
    return response;
  }

  static Future<dynamic> requsetDelete({
    String path,
    Map<String, dynamic> data,
  }) async {
    Uri url = Uri.https(NetworkConstants.baseUrl, path, data);
    Response response = await delete(
      url,
      body: jsonEncode(data),
      headers: {
        "Content-Type": "application/json",
        //"Authorization": 'Bearer <token>',
      },
    );
    return response;
  }

  static Future<dynamic> requsetPut({
    String path,
    Map<String, dynamic> data,
  }) async {
    Uri url = Uri.https(NetworkConstants.baseUrl, path, data);
    Response response = await put(
      url,
      body: jsonEncode(data),
      headers: {
        "Content-Type": "application/json",
        //"Authorization": 'Bearer <token>',
      },
    );
    return response;
  }
}
