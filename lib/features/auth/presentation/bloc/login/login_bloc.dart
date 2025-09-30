import 'package:bazargan/features/auth/data/model/login_model.dart';
import 'package:bazargan/features/auth/data/repository/login_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepositoryImpl repository;

  LoginBloc({required this.repository}) : super(LoginStateInitial()) {
    on<LoginEventRequest>((event, emit) async {
      emit(LoginStateLoading());

      try {
        final Either<String, LoginModel> result = await repository.loginWithOtp(
          phone: event.phoneNumber,
          code: event.code,
        );
        result.fold(
          (left) => emit(LoginStateError(error: left)),
          (right) => emit(LoginStateSuccess(loginResponse: right)),
        );
      } catch (e) {
        emit(LoginStateError(error: e.toString()));
      }
    });
  }
}
