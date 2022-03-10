import 'package:flutter/foundation.dart';

import 'interceptors.dart';
import 'package:dio/dio.dart';

class DioSettings {
  static Dio dio([String? url]) {
    if (url == null) {
      if (kReleaseMode) {
        url = "http://122.54.198.84:84";
      } else {
        url = "http://122.54.198.84:82";
      }
    }
    return Dio(
      BaseOptions(
        baseUrl: url,
        connectTimeout: 5000,
      ),
    )..interceptors.add(Logging());
  }
}
