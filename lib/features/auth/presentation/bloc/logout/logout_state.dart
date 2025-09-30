part of 'logout_bloc.dart';

@immutable
abstract class LogoutState {}

class LogoutStateInitial extends LogoutState {}

class LogoutStateLoading extends LogoutState {}

class LogoutStateSuccess extends LogoutState {}

class LogoutStateError extends LogoutState {
  final String error;

  LogoutStateError({required this.error});
}
