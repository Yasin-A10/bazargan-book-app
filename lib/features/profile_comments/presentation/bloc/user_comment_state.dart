part of 'user_comment_bloc.dart';

class UserCommentState {
  final LoadCommentStatus loadCommentStatus;
  final UpdateCommentStatus updateCommentStatus;
  final DeleteCommentStatus deleteCommentStatus;

  UserCommentState({
    required this.loadCommentStatus,
    required this.updateCommentStatus,
    required this.deleteCommentStatus,
  });

  UserCommentState copyWith({
    LoadCommentStatus? newLoadCommentStatus,
    UpdateCommentStatus? newUpdateCommentStatus,
    DeleteCommentStatus? newDeleteCommentStatus,
  }) {
    return UserCommentState(
      loadCommentStatus: newLoadCommentStatus ?? loadCommentStatus,
      updateCommentStatus: newUpdateCommentStatus ?? updateCommentStatus,
      deleteCommentStatus: newDeleteCommentStatus ?? deleteCommentStatus,
    );
  }
}
