import 'package:equatable/equatable.dart';
import 'package:kapartner_app/presentation/views/default_page/models/cart_item_model/cart_item_model.dart';

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
