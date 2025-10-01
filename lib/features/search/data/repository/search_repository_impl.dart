import 'package:bazargan/features/search/data/models/search_model.dart';
import 'package:bazargan/features/search/data/source/search_api_provider.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl {
  final SearchApiProvider apiProvider;

  SearchRepositoryImpl({required this.apiProvider});

  Future<Either<String, SearchModel>> getSearch(String search) async {
    try {
      final result = await apiProvider.getSearch(search);
      return Right(result);
    } catch (e) {
      return Left('Please try again later...${e.toString()}');
    }
  }
}
