import 'package:equatable/equatable.dart';
import 'package:in_app_update/in_app_update.dart';

abstract class AppInitState extends Equatable {
  const AppInitState();
  @override
  List<Object?> get props => [];
}

class OpeningAppState extends AppInitState {}

// class NewUpdateAvailable extends AppInitState {
//   final VersionModel availableVersion;
//   final PackageInfo devicePackageInfo;

//   const NewUpdateAvailable(this.availableVersion, this.devicePackageInfo);
//   @override
//   List<Object> get props => [availableVersion, devicePackageInfo];
// }
class NewUpdateAvailable extends AppInitState {
  final AppUpdateInfo updateInfo;

  const NewUpdateAvailable(this.updateInfo);
  @override
  List<Object> get props => [updateInfo];
}

class AppInitLoading extends AppInitState {}

class TryingToLogin extends AppInitState {}

class AutoLoginSuccessful extends AppInitState {}

class AutoLoginFailed extends AppInitState {}

class Error extends AppInitState {
  final String message;
  const Error(this.message);
  @override
  List<Object> get props => [message];
}

class NoUpdateAvailable extends AppInitState {}
