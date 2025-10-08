import 'package:bazargan/features/profile_comments/data/model/user_comment_model.dart';
import 'package:bazargan/features/profile_comments/data/source/user_comment_api_provider.dart';
import 'package:dartz/dartz.dart';

class UserCommentRepositoryImpl {
  final UserCommentApiProvider apiProvider;

  UserCommentRepositoryImpl({required this.apiProvider});

  Future<Either<String, UserCommentModel>> getUserComments() async {
    try {
      final result = await apiProvider.getUserComments();
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}
