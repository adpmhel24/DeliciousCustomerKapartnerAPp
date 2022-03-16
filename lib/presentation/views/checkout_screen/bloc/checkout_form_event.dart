import 'package:equatable/equatable.dart';
import 'package:kapartner_app/data/models/cart_item_model/cart_item_model.dart';
import 'package:kapartner_app/data/models/customer_address/customer_address_model.dart';

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
  final CustomerAddressModel? selectedAddress;
  // final String address;
  // final double delfee;

  const AddressChanged(this.selectedAddress);
  @override
  List<Object?> get props => [selectedAddress];
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

class PickupAddressChanged extends CheckoutFormEvent {
  final String pickupAddress;

  const PickupAddressChanged(this.pickupAddress);

  @override
  List<Object?> get props => [pickupAddress];
}

class AddCartItemsInCheckOutState extends CheckoutFormEvent {
  final List<CartItemModel> items;
  const AddCartItemsInCheckOutState(this.items);
  @override
  List<Object?> get props => [items];
}

class NotesChanged extends CheckoutFormEvent {
  final String notes;
  const NotesChanged(this.notes);
  @override
  List<Object?> get props => [notes];
}
