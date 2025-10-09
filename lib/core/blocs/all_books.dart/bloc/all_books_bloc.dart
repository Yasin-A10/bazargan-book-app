import 'package:bazargan/core/blocs/all_books.dart/data/model/all_books_model.dart';
import 'package:bazargan/core/blocs/all_books.dart/data/repository/all_books_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_books_state.dart';
part 'all_books_event.dart';

class AllBooksBloc extends Bloc<AllBooksEvent, AllBooksState> {
  final AllBooksRepositoryImpl repository;

  AllBooksBloc({required this.repository}) : super(AllBooksInitial()) {
    on<LoadAllBooksEvent>((event, emit) async {
      emit(AllBooksLoading());

      try {
        final Either<String, BookListModel> result = await repository
            .getAllBook(event.query);

        result.fold(
          (error) => emit(AllBooksError(error: error)),
          (bookListModel) =>
              emit(AllBooksSuccess(bookListModel: bookListModel)),
        );
      } catch (e) {
        emit(AllBooksError(error: 'ارور بخش بلاک ${e.toString()}'));
      }
    });
  }
}
