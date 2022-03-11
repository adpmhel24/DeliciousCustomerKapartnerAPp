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

  Future<String> updateCustomer({
    required Map<String, dynamic> data,
  }) async {
    Response response;
    String message = 'Updating Customer: Unknown Error!';

    try {
      response = await _customerAPI.updateCustomer(
          _authRepository.currentUser.token,
          customerId: _customer.id!.toString(),
          data: data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        //  Update Customer in local
        _customer = CustomerModel.fromJson(response.data['data']);
        message = response.data['message'];
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
    return message;
  }

  Future<String> updateCustomerDetail({
    required int customerDetailId,
    required Map<String, dynamic> data,
  }) async {
    Response response;
    String message = 'Updating Customer Detail: Unknown Error!';
    try {
      response = await _customerAPI.updateCustomerDetails(
          _authRepository.currentUser.token,
          customerDetailId: customerDetailId,
          data: data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        //  Update Customer in local
        _customer = CustomerModel.fromJson(response.data['data']);
        message = response.data['message'];
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
    return message;
  }

  Future<String> addNewCustomerDetails({
    required int customerId,
    required Map<String, dynamic> data,
  }) async {
    Response response;
    String message = 'Updating Customer Details: Unknown Error!';

    try {
      response = await _customerAPI.addNewCustomerDetails(
          _authRepository.currentUser.token,
          customerId: customerId.toString(),
          data: data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        //  Update Customer in local
        _customer = CustomerModel.fromJson(response.data['data']);
        message = response.data['message'];
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
    return message;
  }

  Future<String> deleteCustomerAddressDetail({
    required int customerDetailsID,
  }) async {
    Response response;
    String message = 'Updating Customer Details: Unknown Error!';

    try {
      response = await _customerAPI.deleteCustomerDetails(
        _authRepository.currentUser.token,
        customerDetailsID: customerDetailsID,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        //  Update Customer in local
        _customer = CustomerModel.fromJson(response.data['data']);
        message = response.data['message'];
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
    return message;
  }

  CustomerAddressModel? defautShippingAddress() {
    int index =
        _customer.details.indexWhere((element) => element!.isDefault! == true);
    if (_customer.details.isNotEmpty) {
      return _customer.details[index];
    }
    return null;
  }
}
