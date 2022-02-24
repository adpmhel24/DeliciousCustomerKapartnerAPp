import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kapartner_app/presentation/utils/text_field_validator.dart';

class LoginFormState extends Equatable {
  final FormzStatus status;
  final TextFieldModel username;
  final TextFieldModel password;
  final String message;

  const LoginFormState({
    this.status = FormzStatus.pure,
    this.username = const TextFieldModel.pure(),
    this.password = const TextFieldModel.pure(),
    this.message = "",
  });

  LoginFormState copyWith({
    FormzStatus? status,
    TextFieldModel? username,
    TextFieldModel? password,
    String? message,
  }) {
    return LoginFormState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        status,
        username,
        password,
        message,
      ];
}
