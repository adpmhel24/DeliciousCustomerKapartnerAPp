import 'package:equatable/equatable.dart';

abstract class DeliveredOrdersEvent extends Equatable {
  const DeliveredOrdersEvent();
  @override
  List<Object?> get props => [];
}

class FetchDeliveredOrders extends DeliveredOrdersEvent {}
