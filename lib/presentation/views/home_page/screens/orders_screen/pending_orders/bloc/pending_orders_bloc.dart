import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kapartner_app/data/repositories/app_repo.dart';
import 'package:kapartner_app/data/repositories/order_repo.dart';

import 'bloc.dart';

class PendingOrderBloc extends Bloc<PendingOrderEvent, PendingOrderState> {
  PendingOrderBloc() : super(const PendingOrderState()) {
    on<FetchPendingOrders>(_onFetchPendingOrders);
  }

  final OrderRepo _orderRepo = AppRepo.orderRepository;

  Future<void> _onFetchPendingOrders(
      FetchPendingOrders event, Emitter<PendingOrderState> emit) async {
    emit(state.copyWith(status: PendingOrderStateStatus.loading));
    try {
      await _orderRepo.fetchAllOrdersByUser(params: {"order_status": 0});
      emit(
        state.copyWith(
          orders: _orderRepo.orders,
          status: PendingOrderStateStatus.success,
        ),
      );
    } on HttpException catch (e) {
      emit(state.copyWith(
          message: e.message, status: PendingOrderStateStatus.error));
    }
  }
}
