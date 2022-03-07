import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../data/repositories/repositories.dart';
import 'bloc.dart';

class DeliveredOrdersBloc
    extends Bloc<DeliveredOrdersEvent, DeliveredOrdersState> {
  DeliveredOrdersBloc() : super(const DeliveredOrdersState()) {
    on<FetchDeliveredOrders>(_onFetchDeliveredOrders);
  }

  final OrderRepo _orderRepo = AppRepo.orderRepository;

  Future<void> _onFetchDeliveredOrders(
      FetchDeliveredOrders event, Emitter<DeliveredOrdersState> emit) async {
    emit(state.copyWith(status: DeliveredOrdersStateStatus.loading));
    try {
      await _orderRepo
          .fetchAllOrdersByUser(params: {"order_status": 2, "docstatus": "C"});
      emit(
        state.copyWith(
          orders: _orderRepo.orders,
          status: DeliveredOrdersStateStatus.success,
        ),
      );
    } on HttpException catch (e) {
      emit(state.copyWith(
          message: e.message, status: DeliveredOrdersStateStatus.error));
    }
  }
}
