import 'package:equatable/equatable.dart';
import 'package:kapartner_app/data/models/models.dart';

enum PendingOrderStateStatus { init, loading, success, error }

class PendingOrderState extends Equatable {
  final PendingOrderStateStatus status;
  final List<OrderItemModel?> orders;
  final String message;

  const PendingOrderState(
      {this.status = PendingOrderStateStatus.init,
      this.orders = const [],
      this.message = ""});

  PendingOrderState copyWith({
    PendingOrderStateStatus? status,
    List<OrderItemModel?>? orders,
    String? message,
  }) {
    return PendingOrderState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, message];
}
