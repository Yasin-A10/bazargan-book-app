import 'package:bazargan/features/book/data/model/book_model.dart';
import 'package:bazargan/features/book/data/repository/book_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_state.dart';
part 'book_event.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepositoryImpl bookRepository;

  BookBloc({required this.bookRepository}) : super(BookInitial()) {
    // get book
    on<LoadBookEvent>((event, emit) async {
      emit(BookLoading());

      try {
        final Either<String, BookModel> result = await bookRepository.getBook(
          event.bookId,
        );

        result.fold(
          (error) => emit(BookError(error: error)),
          (book) => emit(BookSuccess(book: book)),
        );
      } catch (e) {
        emit(BookError(error: 'ارور بخش بلاک ${e.toString()}'));
      }
    });
  }
}
