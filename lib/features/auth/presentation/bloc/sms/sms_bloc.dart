import 'package:bazargan/features/auth/data/repository/sms_sender_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sms_state.dart';
part 'sms_event.dart';

class SmsBloc extends Bloc<SmsEvent, SmsState> {
  final SmsSenderRepositoryImpl repository;
  SmsBloc({required this.repository}) : super(SmsStateInitial()) {
    on<SmsEventRequest>((event, emit) async {
      emit(SmsStateLoading());

      try {
        final Either<String, dynamic> result = await repository.sendSms(
          event.phoneNumber,
        );
        result.fold(
          (left) => emit(SmsStateError(error: left)),
          (right) => emit(SmsStateSuccess(success: right)),
        );
      } catch (e) {
        emit(SmsStateError(error: 'Unexpected error: ${e.toString()}'));
      }
    });
  }
}
