import 'package:equatable/equatable.dart';

abstract class CheckoutFormEvent extends Equatable {
  const CheckoutFormEvent();

  @override
  List<Object?> get props => [];
}

class DeliveryDateChanged extends CheckoutFormEvent {
  final String deliveryDate;
  const DeliveryDateChanged(this.deliveryDate);
  @override
  List<Object?> get props => [deliveryDate];
}

class DeliveryMethodChanged extends CheckoutFormEvent {
  final String deliveryMethod;
  const DeliveryMethodChanged(this.deliveryMethod);
  @override
  List<Object?> get props => [deliveryMethod];
}

class PaymentMethodChange extends CheckoutFormEvent {
  final String paymentMethod;
  const PaymentMethodChange(this.paymentMethod);
  @override
  List<Object?> get props => [paymentMethod];
}

class NotesChanged extends CheckoutFormEvent {
  final String notes;
  const NotesChanged(this.notes);
  @override
  List<Object?> get props => [notes];
}
