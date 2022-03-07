import 'package:equatable/equatable.dart';

abstract class PendingOrderEvent extends Equatable {
  const PendingOrderEvent();
  @override
  List<Object?> get props => [];
}

class FetchPendingOrders extends PendingOrderEvent {}
