import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/repositories/repositories.dart';
import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = AppRepo.authRepository;

  AuthBloc() : super(Unauthenticated()) {
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLogout);
    on<ChangedPassword>(_onChangedPassword);
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) {
    emit(Authenticated(_authRepository.currentUser));
  }

  void _onLogout(LoggedOut event, Emitter<AuthState> emit) {
    emit(Unauthenticated());
    _authRepository.logout();
  }

  void _onChangedPassword(
      ChangedPassword event, Emitter<AuthState> emit) async {
    emit(PasswordUpdating());
    try {
      String message =
          await _authRepository.changePassword({"password": event.password});
      emit(PasswordUpdatedSuccessfully(message));
    } on HttpException catch (e) {
      emit(PasswordUpdatingFailure(e.message));
    }
  }
}
