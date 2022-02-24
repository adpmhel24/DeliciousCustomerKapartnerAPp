import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../data/models/models.dart';

abstract class AppInitState extends Equatable {
  const AppInitState();
  @override
  List<Object?> get props => [];
}

class OpeningAppState extends AppInitState {}

class NewUpdateAvailable extends AppInitState {
  final VersionModel availableVersion;
  final PackageInfo devicePackageInfo;

  const NewUpdateAvailable(this.availableVersion, this.devicePackageInfo);
  @override
  List<Object> get props => [availableVersion, devicePackageInfo];
}

class CheckingUpdate extends AppInitState {}

class Error extends AppInitState {
  final String message;
  const Error(this.message);
  @override
  List<Object> get props => [message];
}

class NoUpdateAvailable extends AppInitState {}
