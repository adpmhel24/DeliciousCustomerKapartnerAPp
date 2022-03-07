import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../data/repositories/repositories.dart';
import 'bloc.dart';

class ToDeliverOrderBloc
    extends Bloc<ToDeliverOrderEvent, ToDeliverOrderState> {
  ToDeliverOrderBloc() : super(const ToDeliverOrderState()) {
    on<FetchToDeliverOrders>(_onFetchToDeliverOrders);
  }

  final OrderRepo _orderRepo = AppRepo.orderRepository;

  Future<void> _onFetchToDeliverOrders(
      FetchToDeliverOrders event, Emitter<ToDeliverOrderState> emit) async {
    emit(state.copyWith(status: ToDeliverOrderStateStatus.loading));
    try {
      await _orderRepo.fetchAllOrdersByUser(params: {"order_status": 1});
      emit(
        state.copyWith(
          orders: _orderRepo.orders,
          status: ToDeliverOrderStateStatus.success,
        ),
      );
    } on HttpException catch (e) {
      emit(state.copyWith(
          message: e.message, status: ToDeliverOrderStateStatus.error));
    }
  }
}
