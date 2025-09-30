import 'package:bazargan/features/home/data/model/home_page_model.dart';
import 'package:bazargan/features/home/data/source/home_api_provider.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl {
  final HomeApiProvider apiProvider;

  HomeRepositoryImpl({required this.apiProvider});

  Future<Either<String, HomePageModel>> getHomePage() async {
    try {
      final result = await apiProvider.getHomePage();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
