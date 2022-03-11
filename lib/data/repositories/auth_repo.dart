import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../../exceptions/auth_expire_exception.dart';
import '../api_services/auth_api.dart';
import '../models/auth_user/auth_user_model.dart';
import 'app_repo.dart';

class AuthRepository extends ChangeNotifier {
  final AuthAPI _authAPI = AuthAPI();
  AuthUserModel? _currentUser;
  bool _authenticated = false;
  bool get authenticated => _authenticated;

  set authenticated(bool value) {
    _authenticated = value;
    notifyListeners();
  }

  AuthUserModel get currentUser => _currentUser!;

  Future<void> loginWithCredentials(
      {required String username, required String password}) async {
    Response response;
    try {
      response =
          await _authAPI.loggedIn(username: username, password: password);
      if (response.statusCode == 200) {
        _currentUser = AuthUserModel.fromJson(response.data['data']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("userData", json.encode(_currentUser!.toJson()));

        // Load or resources after autheticate
        await AppRepo().init();

        // Change the value of authenticated then notify
        _authenticated = true;
        notifyListeners();
      } else {
        throw HttpException(response.data['message']);
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  Future<String> changePassword(Map<String, dynamic> data) async {
    Response response;
    String message = "";
    try {
      response = await _authAPI.changePassword(_currentUser!.token, data: data);

      message = response.data['message'];
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
    return message;
  }

  bool isLoggedIn() => _currentUser != null;

  Future<bool> tryToLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString("userData");
    if (userData != null) {
      Map<String, dynamic> userDecoded = jsonDecode(userData);
      String token = userDecoded['token'];
      try {
        Response response = await _authAPI.verifyToken(token);
        {
          if (response.statusCode == 200) {
            _currentUser = AuthUserModel.fromJson(userDecoded);
            // Load or resources after autheticate
            await AppRepo().init();
            _authenticated = true;
            notifyListeners();
            return true;
          }
        }
      } on AuthExpireException catch (_) {
        await logout();
      } on HttpException catch (e) {
        await logout();
        throw HttpException(e.message);
      }
    }
    return false;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(milliseconds: 500));
    prefs.remove("userData");
    _currentUser = null;

    // Change the value of authenticated then notify
    _authenticated = false;
    notifyListeners();
  }

  ///Singleton factory
  static final AuthRepository _instance = AuthRepository._internal();

  factory AuthRepository() {
    return _instance;
  }

  AuthRepository._internal();
}
