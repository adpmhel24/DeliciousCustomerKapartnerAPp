import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kapartner_app/data/api_services/apis.dart';
import 'package:kapartner_app/data/models/models.dart';

import 'repositories.dart';

class CustomerInfoRepo {
  ///Singleton factory
  static final CustomerInfoRepo _instance = CustomerInfoRepo._internal();

  factory CustomerInfoRepo() {
    return _instance;
  }

  CustomerInfoRepo._internal();

  final AuthRepository _authRepository = AppRepo.authRepository;
  final CustomerAPI _customerAPI = CustomerAPI();

  late CustomerModel _customer;
  CustomerModel get customer => _customer;

  Future<void> getCustomerInfo() async {
    Response response;
    try {
      response = await _customerAPI.getCustomerInfoByCustomerUserId(
          _authRepository.currentUser.token,
          userId: _authRepository.currentUser.id!);

      _instance._customer = CustomerModel.fromJson(response.data['data']);
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }
}
