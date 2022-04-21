import 'package:equatable/equatable.dart';
import 'package:kapartner_app/data/models/models.dart';

enum DeliveredOrdersStateStatus { init, loading, success, error }

class DeliveredOrdersState extends Equatable {
  final DeliveredOrdersStateStatus status;
  final List<OrderItemModel?> orders;
  final String message;

  const DeliveredOrdersState(
      {this.status = DeliveredOrdersStateStatus.init,
      this.orders = const [],
      this.message = ""});

  DeliveredOrdersState copyWith({
    DeliveredOrdersStateStatus? status,
    List<OrderItemModel?>? orders,
    String? message,
  }) {
    return DeliveredOrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, message];
}
