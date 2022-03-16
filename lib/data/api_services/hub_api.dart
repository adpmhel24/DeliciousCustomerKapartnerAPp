import 'dart:io';

import 'package:dio/dio.dart';

import 'dio_settings.dart';

class HubAPI {
  Dio dio = DioSettings.dio();

  Future<Response> getAllHubs(String token) async {
    Response response;
    try {
      response = await dio.get('/api/whse/hubs/get_all',
          options: Options(headers: {
            "Authorization": "Bearer " + token,
          }));
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
}
