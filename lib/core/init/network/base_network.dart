import 'dart:convert';
import 'dart:io';
import 'package:paypara/core/base/model/base_model.dart';
import 'package:paypara/core/constants/app_constant.dart';
import 'package:paypara/core/constants/enums/base_url_enum.dart';
import 'package:paypara/core/constants/enums/preferences_keys_enum.dart';
import 'package:paypara/core/init/locale_manager.dart';
import 'package:http/http.dart' as http;

class BaseService {
  Future<dynamic> get<T extends IBaseModel>({
    BaseURL baseUrl,
    String path,
    IBaseModel model,
    Map<String, dynamic> data,
  }) async {
    final response = await http.get(
      Uri.http(ApplicationConstants.getBaseURL(baseUrl), path, data),
      headers: {
        "content-type": "application/json",
        'Authorization': "Bearer " + LocaleManager.instance.getString(PreferencesKeys.TOKEN),
      },
    ).timeout(
      Duration(seconds: ApplicationConstants.RESPONSE_TIMEOUT),
      /*
      onTimeout: () {
      
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConnectionTimeout(),
          ),
        );
      
      },
        */
    );

    switch (response.statusCode) {
      case HttpStatus.ok:
        return _jsonBodyParser<T>(model, response.body);
        break;
      case HttpStatus.badRequest:
        break;
      case HttpStatus.unauthorized:
        //TODO logout
        break;
      default:
        throw response.body;
    }
  }

  Future<dynamic> post<T extends IBaseModel>({
    BaseURL baseUrl,
    String path,
    IBaseModel model,
    Map<String, dynamic> data,
  }) async {
    final response = await http
        .post(
          Uri.http(ApplicationConstants.getBaseURL(baseUrl), path),
          headers: {
            "content-type": "application/json",
            'Authorization': "Bearer " + LocaleManager.instance.getString(PreferencesKeys.TOKEN),
          },
          body: json.encode(data),
        )
        .timeout(
          Duration(seconds: ApplicationConstants.RESPONSE_TIMEOUT),
          /*
      onTimeout: () {
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConnectionTimeout(),
          ),
        );
      },
      */
        );
    switch (response.statusCode) {
      case HttpStatus.ok:
        return _jsonBodyParser<T>(model, response.body);
        break;
      case HttpStatus.unauthorized:
        //logout
        break;
      case HttpStatus.badRequest:
        //return _jsonBodyParser<T>(model, response.body);
        break;
      default:
        throw response.body;
    }
  }

  dynamic _jsonBodyParser<T>(IBaseModel model, String body) {
    final jsonBody = jsonDecode(body);

    if (jsonBody is List) {
      return jsonBody.map((e) => model.fromJson(e)).toList().cast<T>();
    } else if (jsonBody is Map) {
      return model.fromJson(jsonBody);
    } else {
      return jsonBody;
    }
  }
}
