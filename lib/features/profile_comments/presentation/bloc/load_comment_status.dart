import 'package:bazargan/features/profile_comments/data/model/user_comment_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoadCommentStatus {}

class CommentInitial extends LoadCommentStatus {}

class CommentLoading extends LoadCommentStatus {}

class CommentSuccess extends LoadCommentStatus {
  final UserCommentModel userCommentModel;
  CommentSuccess({required this.userCommentModel});
}

class CommentError extends LoadCommentStatus {
  final String error;
  CommentError({required this.error});
}
