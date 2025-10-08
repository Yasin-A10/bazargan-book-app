part of 'user_comment_bloc.dart';

abstract class UserCommentEvent {}

class LoadUserCommentEvent extends UserCommentEvent {}

class UpdateUserCommentEvent extends UserCommentEvent {
  final int commentId;
  final UpdateCommentModel updateCommentModel;
  UpdateUserCommentEvent({
    required this.commentId,
    required this.updateCommentModel,
  });
}

class DeleteUserCommentEvent extends UserCommentEvent {
  final int commentId;
  DeleteUserCommentEvent({required this.commentId});
}
