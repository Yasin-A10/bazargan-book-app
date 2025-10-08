part of 'user_comment_bloc.dart';

class UserCommentState {
  final LoadCommentStatus loadCommentStatus;

  UserCommentState({required this.loadCommentStatus});

  UserCommentState copyWith({LoadCommentStatus? newLoadCommentStatus}) {
    return UserCommentState(
      loadCommentStatus: newLoadCommentStatus ?? loadCommentStatus,
    );
  }
}
