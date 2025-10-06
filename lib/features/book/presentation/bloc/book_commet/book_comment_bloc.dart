import 'package:bazargan/features/book/data/model/book_comment_modle.dart';
import 'package:bazargan/features/book/data/repository/book_commnet_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_comment_state.dart';
part 'book_comment_event.dart';

class BookCommentBloc extends Bloc<BookCommentEvent, BookCommentState> {
  final BookCommentsRepositoryImpl bookCommentsRepository;

  BookCommentBloc({required this.bookCommentsRepository})
    : super(BookCommentInitial()) {
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
  }
}
