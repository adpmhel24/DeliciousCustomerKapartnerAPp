import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kapartner_app/data/repositories/app_repo.dart';
import 'package:kapartner_app/data/repositories/order_repo.dart';

import 'bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderBlocInitState()) {
    on<PlaceNewOrder>(_onPlaceNewOrder);
  }

  final OrderRepo _orderRepo = AppRepo.orderRepository;

  Future<void> _onPlaceNewOrder(
      PlaceNewOrder event, Emitter<OrderState> emit) async {
    emit(PlaceNewOrderInProgress());
    try {
      String message =
          await _orderRepo.postNewOrder(event.checkoutModel.toJson());
      event.cartItemRepo.clearCart();
      emit(PlaceNewOrderSucess(message));
    } on HttpException catch (e) {
      emit(PlaceNewOrderFailure(e.message));
    }
  }
}
