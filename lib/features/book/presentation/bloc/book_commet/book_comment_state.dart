part of 'book_comment_bloc.dart';

@immutable
class BookCommentState {}

class BookCommentInitial extends BookCommentState {}

class BookCommentLoading extends BookCommentState {}

class BookCommentSuccess extends BookCommentState {
  final BookCommentsModel bookComment;

  BookCommentSuccess({required this.bookComment});
}

class BookCommentError extends BookCommentState {
  final String error;

  BookCommentError({required this.error});
}

// add comment

class AddCommentLoading extends BookCommentState {}

class AddCommentSuccess extends BookCommentState {
  final AddCommentModel addCommentModel;

  AddCommentSuccess({required this.addCommentModel});
}

class AddCommentError extends BookCommentState {
  final String error;

  AddCommentError({required this.error});
}
