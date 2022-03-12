import 'package:equatable/equatable.dart';

abstract class CheckoutFormEvent extends Equatable {
  const CheckoutFormEvent();

  @override
  List<Object?> get props => [];
}

class CustCodeChanged extends CheckoutFormEvent {
  final String custCode;

  const CustCodeChanged(this.custCode);
  @override
  List<Object?> get props => [custCode];
}

class ContactNumberChanged extends CheckoutFormEvent {
  final String contactNumber;

  const ContactNumberChanged(this.contactNumber);
  @override
  List<Object?> get props => [contactNumber];
}

class AddressChanged extends CheckoutFormEvent {
  final String address;
  final double delfee;

  const AddressChanged(this.address, this.delfee);
  @override
  List<Object?> get props => [address, delfee];
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
