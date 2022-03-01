import 'package:equatable/equatable.dart';

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

class PasswordUpdated extends CustomerInfoEvent {
  final String password;
  const PasswordUpdated(this.password);

  @override
  List<Object?> get props => [password];
}
