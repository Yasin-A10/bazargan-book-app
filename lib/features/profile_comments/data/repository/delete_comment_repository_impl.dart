import 'package:bazargan/features/profile_comments/data/source/delete_comment_api_provider.dart';
import 'package:dartz/dartz.dart';

class DeleteCommentRepositoryImpl {
  final DeleteCommentApiProvider apiProvider;

  DeleteCommentRepositoryImpl({required this.apiProvider});

  Future<Either<String, dynamic>> deleteComment(int commentId) async {
    try {
      final result = await apiProvider.deleteComment(commentId);
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}
