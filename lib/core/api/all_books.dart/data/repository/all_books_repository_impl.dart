import 'package:bazargan/core/api/all_books.dart/data/model/all_books_model.dart';
import 'package:bazargan/core/api/all_books.dart/data/source/all_books_api_provider.dart';
import 'package:dartz/dartz.dart';

class AllBooksRepositoryImpl {
  final AllBooksApiProvider apiProvider;

  AllBooksRepositoryImpl({required this.apiProvider});

  Future<Either<String, BookListModel>> getAllBook(AllBooksQuery? query) async {
    try {
      final result = await apiProvider.getAllBook(query);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
