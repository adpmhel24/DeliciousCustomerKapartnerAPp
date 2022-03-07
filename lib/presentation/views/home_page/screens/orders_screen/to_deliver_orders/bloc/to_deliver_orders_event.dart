import 'package:equatable/equatable.dart';

abstract class ToDeliverOrderEvent extends Equatable {
  const ToDeliverOrderEvent();
  @override
  List<Object?> get props => [];
}

class FetchToDeliverOrders extends ToDeliverOrderEvent {}
