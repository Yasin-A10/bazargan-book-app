part of 'book_comment_bloc.dart';

abstract class BookCommentEvent {}

class LoadBookCommentEvent extends BookCommentEvent {
  final int bookId;

  LoadBookCommentEvent({required this.bookId});
}

// add comment

class AddCommentEvent extends BookCommentEvent {
  final int bookId;
  final AddCommentModel addCommentModel;

  AddCommentEvent({required this.bookId, required this.addCommentModel});
}
