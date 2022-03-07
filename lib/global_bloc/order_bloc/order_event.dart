import 'package:equatable/equatable.dart';
import 'package:kapartner_app/data/models/checkout/checkout_model.dart';
import 'package:kapartner_app/data/repositories/cart_items_repo.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
  @override
  List<Object?> get props => [];
}

class PlaceNewOrder extends OrderEvent {
  final CheckOutModel checkoutModel;
  final CartItemsRepo cartItemRepo;

  const PlaceNewOrder(
      {required this.checkoutModel, required this.cartItemRepo});
  @override
  List<Object?> get props => [checkoutModel, cartItemRepo];
}
