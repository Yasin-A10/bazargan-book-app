import 'package:bazargan/features/profile/data/model/user_model.dart';
import 'package:bazargan/features/profile/data/source/user_api_provider.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl {
  final UserApiProvider apiProvider;

  UserRepositoryImpl({required this.apiProvider});

  Future<Either<String, UserModel>> getUser() async {
    try {
      final result = await apiProvider.getUser();
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}
