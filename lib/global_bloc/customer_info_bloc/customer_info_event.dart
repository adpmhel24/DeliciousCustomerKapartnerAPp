import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

abstract class CustomerInfoEvent extends Equatable {
  const CustomerInfoEvent();
  @override
  List<Object?> get props => [];
}

class GetCustomerInfo extends CustomerInfoEvent {}

class ContactNumberUpdated extends CustomerInfoEvent {
  final String contactNumber;
  const ContactNumberUpdated(this.contactNumber);

  @override
  List<Object?> get props => [contactNumber];
}

class EmailAddressUpdated extends CustomerInfoEvent {
  final String email;
  const EmailAddressUpdated(this.email);

  @override
  List<Object?> get props => [email];
}

class UpdateToDefaultAddress extends CustomerInfoEvent {
  final int customerDetailId;
  final bool isDefault;

  const UpdateToDefaultAddress(this.customerDetailId, this.isDefault);
  @override
  List<Object?> get props => [customerDetailId, isDefault];
}

class UpdateCustomerDetail extends CustomerInfoEvent {
  final CustomerAddressModel addressModel;
  const UpdateCustomerDetail(this.addressModel);
  @override
  List<Object?> get props => [addressModel];
}

class AddNewCustomerDetail extends CustomerInfoEvent {
  final CustomerAddressModel addressModel;
  final int customerId;
  const AddNewCustomerDetail(this.customerId, this.addressModel);
  @override
  List<Object?> get props => [customerId, addressModel];
}

class DeleteCustomerAddressDetail extends CustomerInfoEvent {
  final int customerDetailId;
  const DeleteCustomerAddressDetail(this.customerDetailId);
  @override
  List<Object?> get props => [customerDetailId];
}
