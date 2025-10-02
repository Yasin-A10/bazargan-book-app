part of 'marked_books_bloc.dart';

abstract class MarkedBooksEvent {}

class LoadMarkedBooksEvent extends MarkedBooksEvent {}

class AddBookmarkEvent extends MarkedBooksEvent {
  final int bookId;

  AddBookmarkEvent({required this.bookId});
}
