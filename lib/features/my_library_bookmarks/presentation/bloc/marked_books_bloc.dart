import 'package:bazargan/features/my_library_bookmarks/data/model/marked_books_model.dart';
import 'package:bazargan/features/my_library_bookmarks/data/repository/marked_books_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'marked_books_state.dart';
part 'marked_books_event.dart';

class MarkedBooksBloc extends Bloc<MarkedBooksEvent, MarkedBooksState> {
  final MarkedBooksRepositoryImpl repository;

  MarkedBooksBloc({required this.repository}) : super(MarkedBooksInitial()) {
    on<LoadMarkedBooksEvent>((event, emit) async {
      emit(MarkedBooksLoading());

      try {
        final Either<String, MarkedBooksModel> result = await repository
            .getMarkedBooks();

        result.fold(
          (error) => emit(MarkedBooksError(error: error)),
          (markedBooksModel) =>
              emit(MarkedBooksSuccess(markedBooksModel: markedBooksModel)),
        );
      } catch (e) {
        emit(MarkedBooksError(error: 'ارور بخش بلاک ${e.toString()}'));
      }
    });
  }
}
