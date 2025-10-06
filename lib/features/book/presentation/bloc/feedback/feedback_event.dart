part of 'feedback_bloc.dart';

abstract class FeedbackEvent {}

class AddFeedbackEvent extends FeedbackEvent {
  final int bookId;
  final int commentId;
  final FeedbackModel feedbackModel;

  AddFeedbackEvent({
    required this.bookId,
    required this.commentId,
    required this.feedbackModel,
  });
}
