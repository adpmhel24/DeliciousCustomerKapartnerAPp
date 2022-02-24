import 'dart:io';

import '../../data/repositories/repositories.dart';
import './bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppInitBloc extends Bloc<AppInitEvent, AppInitState> {
  AppInitBloc() : super(OpeningAppState()) {
    on<OpeningApp>(onOpeningApp);
  }

  final VersionRepo _versionRepo = VersionRepo();

  void onOpeningApp(OpeningApp event, Emitter<AppInitState> emit) async {
    emit(CheckingUpdate());
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
}
