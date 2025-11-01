import 'package:bazargan/features/book/data/source/book_file_api_provider.dart';
import 'package:dartz/dartz.dart';

class BookFileRepositoryImpl {
  final BookFileApiProvider apiProvider;

  BookFileRepositoryImpl({required this.apiProvider});

  Future<Either<String, dynamic>> getBookFile(
    int bookId,
    Function(double) onProgress,
  ) async {
    try {
      final result = await apiProvider.getBookFile(
        bookId,
        onProgress: (received, total) {
          if (total != -1) {
            onProgress(received / total);
          }
        },
      );
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}
