import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object?> get props => [];
}

class CartBlocInitState extends CartState {}

class AddToCartSubmissionInProgress extends CartState {}

class AddToCartSubmissionComplete extends CartState {}

class AddToCartFailure extends CartState {
  final String message;
  const AddToCartFailure(this.message);
  @override
  List<Object?> get props => [message];
}

class CartItemsLoaded extends CartState {
  final List<CartItemModel> cartItems;

  const CartItemsLoaded(this.cartItems);

  @override
  List<Object?> get props => [cartItems];
}
