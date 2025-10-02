part of 'book_bloc.dart';

@immutable
abstract class BookState {}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookSuccess extends BookState {
  final BookModel book;

  BookSuccess({required this.book});
}

class BookError extends BookState {
  final String error;

  BookError({required this.error});
}
