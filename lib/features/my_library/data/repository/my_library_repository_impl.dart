import 'package:bazargan/features/my_library/data/models/my_library_model.dart';
import 'package:bazargan/features/my_library/data/source/my_librarry_api_provider.dart';
import 'package:dartz/dartz.dart';

class MyLibraryRepositoryImpl {
  final MyLibraryApiProvider apiProvider;

  MyLibraryRepositoryImpl({required this.apiProvider});

  Future<Either<String, MyLibraryModel>> getMyLibrary() async {
    try {
      final result = await apiProvider.getMyLibrary();
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}
