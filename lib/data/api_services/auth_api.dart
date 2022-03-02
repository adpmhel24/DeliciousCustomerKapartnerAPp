import 'dart:io';

import 'package:dio/dio.dart';

import 'dio_settings.dart';

class AuthAPI {
  Dio dio = DioSettings.dio();

  Future<Response> loggedIn({
    required username,
    required password,
  }) async {
    Response response;

    try {
      response = await dio.get('/api/auth/login',
          options: Options(headers: {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Credentials": "true",
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS, GET"
          }),
          queryParameters: {'username': username, 'password': password});
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

  Future<Response> changePassword(token,
      {required Map<String, dynamic> data}) async {
    Response response;

    try {
      response = await dio.put(
        '/api/user/change_pass',
        data: data,
        options: Options(headers: {
          "Authorization": "Bearer " + token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": "true",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS, GET",
          "Content-Type": "application/json",
        }),
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
  static final AuthAPI _instance = AuthAPI._internal();

  factory AuthAPI() {
    return _instance;
  }

  AuthAPI._internal();
}
