import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class CartItemAdded extends CartEvent {
  final CartItemModel cartItem;
  const CartItemAdded(this.cartItem);

  @override
  List<Object?> get props => [cartItem];
}

class GetAllCartItems extends CartEvent {}

class RemoveItemFromCart extends CartEvent {
  final CartItemModel cartItem;

  const RemoveItemFromCart(this.cartItem);

  @override
  List<Object?> get props => [cartItem];
}

class ClearCart extends CartEvent {}
