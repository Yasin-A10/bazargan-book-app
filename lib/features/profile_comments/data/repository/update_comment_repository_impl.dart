import 'package:bazargan/features/profile_comments/data/model/update_comment_model.dart';
import 'package:bazargan/features/profile_comments/data/source/update_comment_api_provider.dart';
import 'package:dartz/dartz.dart';

class UpdateCommentRepositoryImpl {
  final UpdateCommentApiProvider apiProvider;

  UpdateCommentRepositoryImpl({required this.apiProvider});

  Future<Either<String, UpdateCommentModel>> updateComment(
    int commentId,
    UpdateCommentModel updateCommentModel,
  ) async {
    try {
      final result = await apiProvider.updateComment(
        commentId,
        updateCommentModel,
      );
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}
