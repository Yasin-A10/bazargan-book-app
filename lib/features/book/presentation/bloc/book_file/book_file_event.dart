part of 'book_file_bloc.dart';

abstract class BookFileEvent {}

class LoadBookFileEvent extends BookFileEvent {
  final int bookId;

  LoadBookFileEvent({required this.bookId});
}
