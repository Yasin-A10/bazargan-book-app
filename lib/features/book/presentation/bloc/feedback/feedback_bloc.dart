import 'package:bazargan/features/book/data/model/feedback_model.dart';
import 'package:bazargan/features/book/data/repository/feedback_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feedback_state.dart';
part 'feedback_event.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final FeedbackRepositoryImpl feedbackRepository;

  FeedbackBloc({required this.feedbackRepository}) : super(FeedbackInitial()) {
    // Add Feedback
    on<AddFeedbackEvent>((event, emit) async {
      emit(FeedbackLoading());
      try {
        final Either<String, FeedbackModel> result = await feedbackRepository
            .addFeedback(event.bookId, event.commentId, event.feedbackModel);

        result.fold(
          (error) => emit(AddFeedbackError(error: error)),
          (feedbackModel) =>
              emit(AddFeedbackSuccess(feedbackModel: feedbackModel)),
        );
      } catch (e) {
        emit(AddFeedbackError(error: 'ارور بخش بلاک ${e.toString()}'));
      }
    });
  }
}
