import 'package:equatable/equatable.dart';
import 'package:kapartner_app/data/repositories/cart_items_repo.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
  @override
  List<Object?> get props => [];
}

class PlaceNewOrder extends OrderEvent {
  final Map<String, dynamic> data;
  final CartItemsRepo cartItemRepo;

  const PlaceNewOrder({required this.data, required this.cartItemRepo});
  @override
  List<Object?> get props => [data, cartItemRepo];
}
