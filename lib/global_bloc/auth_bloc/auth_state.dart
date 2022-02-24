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
