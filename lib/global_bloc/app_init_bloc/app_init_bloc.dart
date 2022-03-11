import 'dart:io';

import 'package:kapartner_app/exceptions/auth_expire_exception.dart';

import '../../data/repositories/repositories.dart';
import './bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppInitBloc extends Bloc<AppInitEvent, AppInitState> {
  AppInitBloc() : super(OpeningAppState()) {
    on<OpeningApp>(onOpeningApp);
    on<AutoLogin>(onAutoLogin);
  }

  final VersionRepo _versionRepo = VersionRepo();
  final AuthRepository _authRepo = AppRepo.authRepository;

  void onOpeningApp(OpeningApp event, Emitter<AppInitState> emit) async {
    emit(AppInitLoading());
    // Check if there's update available.
    try {
      if (await _versionRepo.isUpdatedAvailable()) {
        emit(NewUpdateAvailable(
            _versionRepo.currentVersion, _versionRepo.packageInfo));
      } else {
        emit(NoUpdateAvailable());
      }
    } on HttpException catch (e) {
      emit(Error(e.message));
    }
  }

  void onAutoLogin(AutoLogin event, Emitter<AppInitState> emit) async {
    try {
      bool successAutoLogin = await _authRepo.tryToLogin();
      if (successAutoLogin) {
        emit(AutoLoginSuccessful());
      }
    } on AuthExpireException catch (_) {
    } on HttpException catch (e) {
      emit(Error(e.message));
    }
  }
}
