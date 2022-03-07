import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kapartner_app/data/repositories/cart_items_repo.dart';

import 'bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartBlocInitState()) {
    on<CartItemAdded>(_onCartItemAdded);
    on<GetAllCartItems>(_onGetAllCartItems);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
    on<ClearCart>(_onClearCart);
  }

  final CartItemsRepo _cartItemsRepo = CartItemsRepo();

  Future<void> _onCartItemAdded(
      CartItemAdded event, Emitter<CartState> emit) async {
    emit(AddToCartSubmissionInProgress());
    try {
      await _cartItemsRepo.addToCart(event.cartItem);
      emit(AddToCartSubmissionComplete());
    } on Exception catch (e) {
      emit(AddToCartFailure(e.toString()));
    }
  }

  void _onGetAllCartItems(GetAllCartItems event, Emitter<CartState> emit) {
    emit(CartItemsLoaded(_cartItemsRepo.cartItems));
  }

  void _onRemoveItemFromCart(
      RemoveItemFromCart event, Emitter<CartState> emit) {
    _cartItemsRepo.deleteFromCart(event.cartItem);
    emit(CartItemsLoaded(_cartItemsRepo.cartItems));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    await _cartItemsRepo.clearCart();
    emit(CartItemsLoaded(_cartItemsRepo.cartItems));
  }
}
