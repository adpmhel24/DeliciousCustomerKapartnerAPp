import 'dart:io';

import 'package:dio/dio.dart';

import 'dio_settings.dart';

class PhLocationApiService {
  final Dio _dio = DioSettings.dio('https://psgc.gitlab.io/api');

  Future<Response> fetchData(String path) async {
    Response _response;
    try {
      _response = await _dio.get(path);
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
    return _response;
  }
}
