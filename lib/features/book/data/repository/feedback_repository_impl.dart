import 'package:bazargan/features/book/data/model/feedback_model.dart';
import 'package:bazargan/features/book/data/source/feedback_api_provider.dart';
import 'package:dartz/dartz.dart';

class FeedbackRepositoryImpl {
  final FeedbackApiProvider apiProvider;

  FeedbackRepositoryImpl({required this.apiProvider});

  Future<Either<String, FeedbackModel>> addFeedback(
    int bookId,
    int commentId,
    FeedbackModel feedbackModel,
  ) async {
    try {
      final result = await apiProvider.addFeedback(
        bookId,
        commentId,
        feedbackModel,
      );
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}
