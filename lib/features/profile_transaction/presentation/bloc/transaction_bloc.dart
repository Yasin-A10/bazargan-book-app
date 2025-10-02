import 'package:bazargan/features/profile_transaction/data/repository/user_transaction_repository_impl.dart';
import 'package:bazargan/features/profile_transaction/data/model/user_transaction_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transaction_state.dart';
part 'transaction_event.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final UserTransactionRepositoryImpl repository;

  TransactionBloc({required this.repository}) : super(TransactionInitial()) {
    on<LoadTransactionEvent>((event, emit) async {
      emit(TransactionLoading());

      try {
        final Either<String, UserTransactionModel> result = await repository
            .getUserTransaction();

        result.fold(
          (error) => emit(TransactionError(error: error)),
          (userTransactionModel) => emit(
            TransactionSuccess(userTransactionModel: userTransactionModel),
          ),
        );
      } catch (e) {
        emit(TransactionError(error: 'ارور بخش بلاک ${e.toString()}'));
      }
    });
  }
}
