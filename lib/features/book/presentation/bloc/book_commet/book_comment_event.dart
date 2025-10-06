part of 'book_comment_bloc.dart';

abstract class BookCommentEvent {}

class LoadBookCommentEvent extends BookCommentEvent {
  final int bookId;

  LoadBookCommentEvent({required this.bookId});
}
