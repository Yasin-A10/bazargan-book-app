import 'package:bazargan/features/profile_favorites/data/source/add_favorite_api_provider.dart';
import 'package:dartz/dartz.dart';

class AddFavoriteRepositoryImpl {
  final AddFavoriteApiProvider apiProvider;

  AddFavoriteRepositoryImpl({required this.apiProvider});

  Future<Either<String, Map<String, dynamic>>> addFavorite(
    List<int> categoryIds,
  ) async {
    try {
      final result = await apiProvider.addFavorite(categoryIds);
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}
