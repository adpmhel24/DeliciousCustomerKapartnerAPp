import 'dart:io';

import 'package:dio/dio.dart';

import '../repositories/repositories.dart';
import 'dio_settings.dart';

class ProductsAPI {
  Dio dio = DioSettings.dio();

  final AuthRepository _authRepository = AuthRepository();

  Future<Response> getAllItem({
    required String token,
  }) async {
    Response response;
    try {
      response = await dio.get('/api/item/getall',
          options: Options(headers: {
            "Authorization": "Bearer " + token,
          }));
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          _authRepository.logout();
        }
        if (e.response!.data.runtimeType != String) {
          throw HttpException(e.response!.data['message']);
        } else {
          throw HttpException(
            "Error Code ${e.response!.statusCode}: ${e.response!.statusMessage}",
          );
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
  static final ProductsAPI _instance = ProductsAPI._internal();

  factory ProductsAPI() {
    return _instance;
  }

  ProductsAPI._internal();
}
