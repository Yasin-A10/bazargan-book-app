import 'package:bazargan/features/book/data/repository/book_file_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_file_state.dart';
part 'book_file_event.dart';

class BookFileBloc extends Bloc<BookFileEvent, BookFileState> {
  final BookFileRepositoryImpl bookFileRepository;

  BookFileBloc({required this.bookFileRepository}) : super(BookFileInitial()) {
    on<LoadBookFileEvent>((event, emit) async {
      emit(BookFileLoading(bookId: event.bookId));

      try {
        final Either<String, dynamic> result = await bookFileRepository
            .getBookFile(
              event.bookId,
              (progress) => emit(BookFileProgress(progress: progress)),
            );

        result.fold(
          (error) => emit(BookFileError(error: error)),
          (file) => emit(BookFileLoaded(bookId: event.bookId, file: file)),
        );
      } catch (e) {
        emit(BookFileError(error: 'ارور بخش بلاک ${e.toString()}'));
      }
    });
  }
}
