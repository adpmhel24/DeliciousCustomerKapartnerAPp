import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  const OrderState();
  @override
  List<Object?> get props => [];
}

class OrderBlocInitState extends OrderState {}

class PlaceNewOrderInProgress extends OrderState {}

class PlaceNewOrderSucess extends OrderState {
  final String message;
  const PlaceNewOrderSucess(this.message);
  @override
  List<Object?> get props => [message];
}

class PlaceNewOrderFailure extends OrderState {
  final String message;
  const PlaceNewOrderFailure(this.message);
  @override
  List<Object?> get props => [message];
}
