part of 'user_comment_bloc.dart';

class UserCommentState {
  final LoadCommentStatus loadCommentStatus;
  final UpdateCommentStatus updateCommentStatus;

  UserCommentState({
    required this.loadCommentStatus,
    required this.updateCommentStatus,
  });

  UserCommentState copyWith({
    LoadCommentStatus? newLoadCommentStatus,
    UpdateCommentStatus? newUpdateCommentStatus,
  }) {
    return UserCommentState(
      loadCommentStatus: newLoadCommentStatus ?? loadCommentStatus,
      updateCommentStatus: newUpdateCommentStatus ?? updateCommentStatus,
    );
  }
}
