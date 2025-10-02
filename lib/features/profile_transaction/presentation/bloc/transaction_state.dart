part of 'transaction_bloc.dart';

@immutable
abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionSuccess extends TransactionState {
  final UserTransactionModel userTransactionModel;

  TransactionSuccess({required this.userTransactionModel});
}

class TransactionError extends TransactionState {
  final String error;

  TransactionError({required this.error});
}
