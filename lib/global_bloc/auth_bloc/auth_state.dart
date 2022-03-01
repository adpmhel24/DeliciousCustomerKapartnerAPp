import 'package:equatable/equatable.dart';

import '../../data/models/auth_user/auth_user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Unintialized extends AuthState {}

class Authenticated extends AuthState {
  final AuthUserModel loggedUser;

  const Authenticated(this.loggedUser);

  @override
  List<Object> get props => [loggedUser];

  @override
  String toString() {
    return 'Authenticated{username: ${loggedUser.fullname}}';
  }
}

class Unauthenticated extends AuthState {}

class PasswordUpdating extends AuthState {}

class PasswordUpdatedSuccessfully extends AuthState {
  final String message;
  const PasswordUpdatedSuccessfully(this.message);

  @override
  List<Object> get props => [message];
}

class PasswordUpdatingFailure extends AuthState {
  final String message;
  const PasswordUpdatingFailure(this.message);

  @override
  List<Object> get props => [message];
}
