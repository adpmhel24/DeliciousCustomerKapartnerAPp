import 'package:equatable/equatable.dart';

import '../../../data/models/models.dart';

abstract class CityMunicipalityState extends Equatable {
  const CityMunicipalityState();
  @override
  List<Object?> get props => [];
}

class CityMunicipalityInitState extends CityMunicipalityState {}

class CityMunicipalityLoadingState extends CityMunicipalityState {}

class CityMunicipalityLoadedState extends CityMunicipalityState {
  final List<CityMunicipalityModel> citiesMunicipalities;
  const CityMunicipalityLoadedState(this.citiesMunicipalities);
  @override
  List<Object?> get props => [citiesMunicipalities];
}

class CityMunicipalityEmptyState extends CityMunicipalityState {}

class CityMunicipalityErrorState extends CityMunicipalityState {
  final String message;
  const CityMunicipalityErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
