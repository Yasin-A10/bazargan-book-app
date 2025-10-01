import 'package:bazargan/features/profile/data/source/update_name_api_provider.dart';
import 'package:dartz/dartz.dart';

class UpdateNameRepositoryImpl {
  final UpdateNameApiProvider apiProvider;

  UpdateNameRepositoryImpl({required this.apiProvider});

  Future<Either<String, Map<String, dynamic>>> updateName(String name) async {
    try {
      final result = await apiProvider.updateName(name);
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}
