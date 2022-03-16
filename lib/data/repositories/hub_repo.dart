import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kapartner_app/data/api_services/apis.dart';
import 'package:kapartner_app/data/models/models.dart';

import 'repositories.dart';

class HubRepo {
  List<HubModel> _hubs = [];

  List<HubModel> get hubs => [..._hubs];

  final HubAPI _hubAPI = HubAPI();
  final AuthRepository _authRepository = AppRepo.authRepository;

  Future<void> fetchAllHub() async {
    final String token = _authRepository.currentUser.token;
    Response response;

    try {
      response = await _hubAPI.getAllHubs(token);
      _hubs = List<HubModel>.from(
        response.data['data'].map(
          (e) => HubModel.fromJson(e),
        ),
      ).toList();
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }
}
