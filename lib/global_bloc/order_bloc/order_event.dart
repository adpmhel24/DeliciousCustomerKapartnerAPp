import 'package:equatable/equatable.dart';
import 'package:kapartner_app/data/models/models.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
  @override
  List<Object?> get props => [];
}

class PlaceNewOrder extends OrderEvent {
  final CustomerModel customerModel;
  final List<OrderItemModel> orderItems;
  final String? deliveryNotes;

  const PlaceNewOrder({
    required this.customerModel,
    required this.orderItems,
    required this.deliveryNotes,
  });
  @override
  List<Object?> get props => [customerModel, orderItems, deliveryNotes];
}
