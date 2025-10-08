import 'package:bazargan/features/profile_comments/data/model/update_comment_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UpdateCommentStatus {}

class UpdateCommentInitial extends UpdateCommentStatus {}

class UpdateCommentLoading extends UpdateCommentStatus {}

class UpdateCommentSuccess extends UpdateCommentStatus {
  final UpdateCommentModel updateCommentModel;
  UpdateCommentSuccess({required this.updateCommentModel});
}

class UpdateCommentError extends UpdateCommentStatus {
  final String error;
  UpdateCommentError({required this.error});
}
