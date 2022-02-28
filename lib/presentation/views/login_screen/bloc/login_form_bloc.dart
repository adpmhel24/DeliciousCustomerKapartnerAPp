import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kapartner_app/data/repositories/app_repo.dart';
import 'package:kapartner_app/data/repositories/auth_repo.dart';
import 'package:kapartner_app/presentation/utils/text_field_validator.dart';
import 'package:kapartner_app/presentation/views/login_screen/bloc/bloc.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc() : super(const LoginFormState()) {
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onUsernameChanged(UsernameChanged event, Emitter<LoginFormState> emit) {
    final username = TextFieldModel.dirty(event.usernameController.text);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([username, state.password]),
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginFormState> emit) {
    final password = TextFieldModel.dirty(event.passwordController.text);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([password, state.username]),
      ),
    );
  }

  void _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginFormState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final AuthRepository _authRepo = AppRepo.authRepository;
    try {
      await _authRepo.loginWithCredentials(
          username: state.username.value, password: state.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on HttpException catch (e) {
      emit(
        state.copyWith(
            message: e.message, status: FormzStatus.submissionFailure),
      );
    }
  }
}
