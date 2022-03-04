import 'dart:io';

import 'package:dio/dio.dart';

import 'dio_settings.dart';

class CustomerAPI {
  Dio dio = DioSettings.dio();

  Future<Response> getCustomerInfoByCustomerUserId(token,
      {required int userId}) async {
    Response response;
    try {
      response = await dio.get('/api/customer/get_by_user_id/$userId',
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

  Future<Response> updateCustomer(
    token, {
    required String customerId,
    required Map<String, dynamic> data,
  }) async {
    Response response;
    try {
      response = await dio.put('/api/customer/update/$customerId',
          data: data,
          options: Options(headers: {
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json",
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

  Future<Response> updateCustomerDetails(
    token, {
    required int customerDetailId,
    required Map<String, dynamic> data,
  }) async {
    Response response;
    try {
      response = await dio.put(
          '/api/customer/contact_details/update/$customerDetailId',
          data: data,
          options: Options(headers: {
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json",
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
