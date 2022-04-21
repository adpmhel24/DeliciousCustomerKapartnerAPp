import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kapartner_app/data/repositories/repositories.dart';

import 'dio_settings.dart';

class OrderAPI {
  Dio dio = DioSettings.dio();
  final AuthRepository _authRepository = AuthRepository();

  Future<Response> getMyOrders(
      {required String token, Map<String, dynamic>? params}) async {
    Response response;
    try {
      response = await dio.get(
        '/api/ordering/get_by_customer_user',
        queryParameters: params,
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
        ),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          _authRepository.logout();
        }
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

  Future<Response> postNewOrder(
      {required String token, required Map<String, dynamic> data}) async {
    Response response;

    List<File> files = data.remove('files');
    List<String> rows = data.remove('rows');
    FormData formData = FormData.fromMap(data);
    if (files.isNotEmpty) {
      for (var e in files) {
        formData.files.add(
          MapEntry(
            'files',
            await MultipartFile.fromFile(
              e.path,
              filename: e.path.split('/').last,
              contentType: MediaType("image", "jpeg"),
            ),
          ),
        );
      }
    }
    for (var e in rows) {
      formData.fields.add(
        MapEntry(
          "rows",
          e,
        ),
      );
    }

    try {
      response = await dio.post(
        '/api/ordering/new/with_attachment',
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
            'Accept': 'application/json',
            'Content-Type': 'multipart/form-data',
          },
          responseType: ResponseType.json,
        ),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          _authRepository.logout();
        }
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

  Future<Response> addOrderAttachment(String token,
      {required orderId, required List<File> files}) async {
    Response response;

    FormData formData = FormData();
    if (files.isNotEmpty) {
      for (var e in files) {
        formData.files.add(
          MapEntry(
            'files',
            await MultipartFile.fromFile(
              e.path,
              filename: e.path.split('/').last,
              contentType: MediaType("image", "jpeg"),
            ),
          ),
        );
      }
    }

    try {
      response = await dio.post(
        '/api/ordering/update/attachment/add/$orderId',
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
            'Accept': 'application/json',
            'Content-Type': 'multipart/form-data',
          },
          responseType: ResponseType.json,
        ),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          _authRepository.logout();
        }
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
  static final OrderAPI _instance = OrderAPI._internal();

  factory OrderAPI() {
    return _instance;
  }

  OrderAPI._internal();
}
