import 'package:bazargan/features/book/data/model/book_comment_modle.dart';
import 'package:bazargan/features/book/data/source/book_comment_api_provider.dart';
import 'package:dartz/dartz.dart';

class BookCommentsRepositoryImpl {
  final BookCommentApiProvider apiProvider;

  BookCommentsRepositoryImpl({required this.apiProvider});

  Future<Either<String, BookCommentsModel>> getBookComments(int bookId) async {
    try {
      final result = await apiProvider.getBookComments(bookId);
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}
