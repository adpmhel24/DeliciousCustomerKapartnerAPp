part of 'addtocart_bloc.dart';

abstract class AddtocartblocEvent extends Equatable {
  const AddtocartblocEvent();

  @override
  List<Object> get props => [];
}

class QuantityChanged extends AddtocartblocEvent {
  final double quantity;
  final double price;
  final double discprcnt;
  const QuantityChanged(
      {required this.quantity, required this.price, required this.discprcnt});
  @override
  List<Object> get props => [quantity, price, discprcnt];
}
