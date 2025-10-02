part of 'marked_books_bloc.dart';

@immutable
abstract class MarkedBooksState {}

class MarkedBooksInitial extends MarkedBooksState {}

class MarkedBooksLoading extends MarkedBooksState {}

class MarkedBooksSuccess extends MarkedBooksState {
  final MarkedBooksModel markedBooksModel;

  MarkedBooksSuccess({required this.markedBooksModel});
}

class MarkedBooksError extends MarkedBooksState {
  final String error;

  MarkedBooksError({required this.error});
}

//add bookmark
class AddBookmarkLoading extends MarkedBooksState {}

class AddBookmarkSuccess extends MarkedBooksState {
  final Map<String, dynamic> bookmark;

  AddBookmarkSuccess({required this.bookmark});
}

class AddBookmarkError extends MarkedBooksState {
  final String error;

  AddBookmarkError({required this.error});
}
