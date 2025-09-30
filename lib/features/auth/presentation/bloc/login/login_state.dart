part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginStateInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateSuccess extends LoginState {
  final LoginModel loginResponse;

  LoginStateSuccess({required this.loginResponse});
}

class LoginStateError extends LoginState {
  final String error;

  LoginStateError({required this.error});
}
