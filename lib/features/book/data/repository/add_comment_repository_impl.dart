import 'package:bazargan/features/book/data/model/add_comment_model.dart';
import 'package:bazargan/features/book/data/source/add_comment_api_provider.dart';
import 'package:dartz/dartz.dart';

class AddCommentRepositoryImpl {
  final AddCommentApiProvider apiProvider;

  AddCommentRepositoryImpl({required this.apiProvider});

  Future<Either<String, AddCommentModel>> addComment(
    int bookId,
    AddCommentModel addCommentModel,
  ) async {
    try {
      final result = await apiProvider.addComment(bookId, addCommentModel);
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}
