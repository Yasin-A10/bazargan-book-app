part of 'sms_bloc.dart';

@immutable
abstract class SmsState {}

class SmsStateInitial extends SmsState {}

class SmsStateLoading extends SmsState {}

class SmsStateSuccess extends SmsState {
  final dynamic success;

  SmsStateSuccess({required this.success});
}

class SmsStateError extends SmsState {
  final String error;

  SmsStateError({required this.error});
}
