import 'package:bazargan/features/my_library_bookmarks/data/model/marked_books_model.dart';
import 'package:bazargan/features/my_library_bookmarks/data/source/marked_books_api_provider.dart';
import 'package:dartz/dartz.dart';

class MarkedBooksRepositoryImpl {
  final MarkedBooksApiProvider apiProvider;

  MarkedBooksRepositoryImpl({required this.apiProvider});

  Future<Either<String, MarkedBooksModel>> getMarkedBooks() async {
    try {
      final result = await apiProvider.getMarkedBooks();
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}
