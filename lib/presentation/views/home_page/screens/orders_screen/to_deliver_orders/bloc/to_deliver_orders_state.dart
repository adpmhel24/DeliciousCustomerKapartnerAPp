import 'package:equatable/equatable.dart';
import 'package:kapartner_app/data/models/models.dart';

enum ToDeliverOrderStateStatus { init, loading, success, error }

class ToDeliverOrderState extends Equatable {
  final ToDeliverOrderStateStatus status;
  final List<OrderItemModel?> orders;
  final String message;

  const ToDeliverOrderState(
      {this.status = ToDeliverOrderStateStatus.init,
      this.orders = const [],
      this.message = ""});

  ToDeliverOrderState copyWith({
    ToDeliverOrderStateStatus? status,
    List<OrderItemModel?>? orders,
    String? message,
  }) {
    return ToDeliverOrderState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, message];
}
