import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticationStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {}

class LoggedOut extends AuthEvent {}

class ChangedPassword extends AuthEvent {
  final String password;
  const ChangedPassword(this.password);
  @override
  List<Object?> get props => [password];
}
