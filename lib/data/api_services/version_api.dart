import 'dart:io';

import 'package:dio/dio.dart';

import 'dio_settings.dart';

class VersionAPI {
  Dio dio = DioSettings.dio();
  // Login Request
  Future<Response> getLatestVersion(Map<String, dynamic> params) async {
    Response response;

    try {
      response = await dio.get(
        '/api/f_e/version/get_version',
        options: Options(headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": "true",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS, GET"
        }),
        queryParameters: params,
      );
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.data.runtimeType != String) {
          throw HttpException(e.response!.data['message']);
        } else {
          throw HttpException(
              "Error Code ${e.response!.statusCode}: ${e.response!.statusMessage}");
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        throw const HttpException("Connection timed out");
      } else {
        throw HttpException(e.message);
      }
    }
    return response;
  }

  ///Singleton factory
  static final VersionAPI _instance = VersionAPI._internal();

  factory VersionAPI() {
    return _instance;
  }

  VersionAPI._internal();
}
