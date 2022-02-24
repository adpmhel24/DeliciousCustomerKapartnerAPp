import 'dart:io';

import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../api_services/apis.dart';
import '../models/models.dart';

class VersionRepo {
  final VersionAPI _versionAPI = VersionAPI();
  late PackageInfo _packageInfo;
  late VersionModel _currentVersion;

  VersionModel get currentVersion => _currentVersion;
  PackageInfo get packageInfo => _packageInfo;

  Future<bool> isUpdatedAvailable() async {
    _packageInfo = await PackageInfo.fromPlatform();
    Response response;
    try {
      response = await _versionAPI.getLatestVersion(
          {"platform": "android", "packageName": _packageInfo.packageName});
      if (response.statusCode == 200) {
        _currentVersion = VersionModel.fromJson(response.data['data']);
      }

      if (_packageInfo.version != _currentVersion.version ||
          _currentVersion.buildNumber > int.parse(_packageInfo.buildNumber)) {
        return true;
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
    return false;
  }
}
