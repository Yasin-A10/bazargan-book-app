import 'package:bazargan/features/book/data/model/add_comment_model.dart';
import 'package:bazargan/features/book/data/model/book_comment_modle.dart';
import 'package:bazargan/features/book/data/repository/add_comment_repository_impl.dart';
import 'package:bazargan/features/book/data/repository/book_commnet_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_comment_state.dart';
part 'book_comment_event.dart';

class BookCommentBloc extends Bloc<BookCommentEvent, BookCommentState> {
  final BookCommentsRepositoryImpl bookCommentsRepository;
  final AddCommentRepositoryImpl addCommentRepository;

  BookCommentBloc({
    required this.bookCommentsRepository,
    required this.addCommentRepository,
  }) : super(BookCommentInitial()) {
    // get Book Comments
    on<LoadBookCommentEvent>((event, emit) async {
      emit(BookCommentLoading());

      try {
        final Either<String, BookCommentsModel> result =
            await bookCommentsRepository.getBookComments(event.bookId);

        result.fold(
          (error) => emit(BookCommentError(error: error)),
          (bookComment) => emit(BookCommentSuccess(bookComment: bookComment)),
        );
      } catch (e) {
        emit(BookCommentError(error: 'ارور بخش بلاک ${e.toString()}'));
      }
    });

    // add comment
    on<AddCommentEvent>((event, emit) async {
      emit(AddCommentLoading());

      try {
        final Either<String, AddCommentModel> result =
            await addCommentRepository.addComment(
              event.bookId,
              event.addCommentModel,
            );

        result.fold(
          (error) => emit(AddCommentError(error: error)),
          (addCommentModel) =>
              emit(AddCommentSuccess(addCommentModel: addCommentModel)),
        );
      } catch (e) {
        emit(AddCommentError(error: 'ارور بخش بلاک ${e.toString()}'));
      }
    });
  }
}
