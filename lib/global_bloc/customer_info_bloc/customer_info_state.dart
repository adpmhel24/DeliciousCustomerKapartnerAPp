import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class CustomerInfoState extends Equatable {
  const CustomerInfoState();
  @override
  List<Object?> get props => [];
}

class CustomerInfoInitState extends CustomerInfoState {}

class CustomerInfoLoading extends CustomerInfoState {}

class CustomerInfoLoaded extends CustomerInfoState {
  final CustomerModel customerInfo;
  const CustomerInfoLoaded(this.customerInfo);
  @override
  List<Object?> get props => [customerInfo];
}

class CustomerInfoError extends CustomerInfoState {
  final String message;
  const CustomerInfoError(this.message);
  @override
  List<Object?> get props => [message];
}
