part of 'feedback_bloc.dart';

// Add Feedback
@immutable
abstract class FeedbackState {}

class FeedbackInitial extends FeedbackState {}

class FeedbackLoading extends FeedbackState {}

class AddFeedbackSuccess extends FeedbackState {
  final FeedbackModel feedbackModel;

  AddFeedbackSuccess({required this.feedbackModel});
}

class AddFeedbackError extends FeedbackState {
  final String error;

  AddFeedbackError({required this.error});
}
