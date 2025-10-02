import 'package:bazargan/features/book/data/model/book_model.dart';
import 'package:bazargan/features/book/data/source/book_api_provider.dart';
import 'package:dartz/dartz.dart';

class BookRepositoryImpl {
  final BookApiProvider apiProvider;

  BookRepositoryImpl({required this.apiProvider});

  Future<Either<String, BookModel>> getBook(int bookId) async {
    try {
      final result = await apiProvider.getBook(bookId);
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}
