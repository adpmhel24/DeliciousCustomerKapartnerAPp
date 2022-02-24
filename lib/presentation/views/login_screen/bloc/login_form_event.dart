import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginFormEvent extends Equatable {
  const LoginFormEvent();
  @override
  List<Object?> get props => [];
}

class UsernameChanged extends LoginFormEvent {
  final TextEditingController usernameController;
  const UsernameChanged(this.usernameController);
  @override
  List<Object?> get props => [usernameController];
}

class PasswordChanged extends LoginFormEvent {
  final TextEditingController passwordController;
  const PasswordChanged(this.passwordController);
  @override
  List<Object?> get props => [passwordController];
}

class LoginSubmitted extends LoginFormEvent {}
