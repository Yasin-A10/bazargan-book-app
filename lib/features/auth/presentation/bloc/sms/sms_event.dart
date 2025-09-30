part of 'sms_bloc.dart';

abstract class SmsEvent {}

class SmsEventRequest extends SmsEvent {
  final String phoneNumber;

  SmsEventRequest({required this.phoneNumber});
}
