import 'package:bazargan/features/my_library_bookmarks/data/source/add_bookmark_api_provider.dart';
import 'package:dartz/dartz.dart';

class AddBookmarkRepositoryImpl {
  final AddBookmarkApiProvider apiProvider;

  AddBookmarkRepositoryImpl({required this.apiProvider});

  Future<Either<String, Map<String, dynamic>>> addBookmark(int bookId) async {
    try {
      final result = await apiProvider.addBookmark(bookId);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
