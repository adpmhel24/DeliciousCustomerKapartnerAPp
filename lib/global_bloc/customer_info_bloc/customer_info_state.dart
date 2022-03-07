import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

enum CustomerInfoStateStatus { init, loading, fetched, error }

class CustomerInfoState extends Equatable {
  final CustomerInfoStateStatus status;
  final CustomerModel? customerInfo;
  final String? message;

  const CustomerInfoState({
    this.status = CustomerInfoStateStatus.init,
    this.customerInfo,
    this.message,
  });

  CustomerInfoState copyWith({
    CustomerInfoStateStatus? status,
    CustomerModel? customerInfo,
    String? message,
  }) {
    return CustomerInfoState(
      status: status ?? this.status,
      customerInfo: customerInfo ?? this.customerInfo,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status];
}
