part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginEventRequest extends LoginEvent {
  final String phoneNumber;
  final String code;

  LoginEventRequest({required this.phoneNumber, required this.code});
}
