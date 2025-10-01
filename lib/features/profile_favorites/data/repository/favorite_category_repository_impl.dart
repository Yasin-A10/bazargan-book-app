import 'package:bazargan/features/profile_favorites/data/model/favorite_category_model.dart';
import 'package:bazargan/features/profile_favorites/data/source/favorite_category_api_provider.dart';
import 'package:dartz/dartz.dart';

class FavoriteCategoryRepositoryImpl {
  final FavoriteCategoryApiProvider apiProvider;

  FavoriteCategoryRepositoryImpl({required this.apiProvider});

  Future<Either<String, FavoriteCategoryModel>> getFavoriteCategories() async {
    try {
      final result = await apiProvider.getFavoriteCategories();
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}
