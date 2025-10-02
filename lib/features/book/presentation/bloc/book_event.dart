part of 'book_bloc.dart';

abstract class BookEvent {}

class LoadBookEvent extends BookEvent {
  final int bookId;

  LoadBookEvent({required this.bookId});
}
