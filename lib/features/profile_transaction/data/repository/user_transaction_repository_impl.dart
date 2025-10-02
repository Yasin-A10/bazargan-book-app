import 'package:bazargan/features/profile_transaction/data/model/user_transaction_model.dart';
import 'package:bazargan/features/profile_transaction/data/source/user_transaction_api_providr.dart';
import 'package:dartz/dartz.dart';

class UserTransactionRepositoryImpl {
  final UserTransactionApiProvider apiProvider;

  UserTransactionRepositoryImpl({required this.apiProvider});

  Future<Either<String, UserTransactionModel>> getUserTransaction() async {
    try {
      final result = await apiProvider.getUserTransaction();
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}
