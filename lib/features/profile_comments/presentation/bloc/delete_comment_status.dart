import 'package:flutter/material.dart';

@immutable
abstract class DeleteCommentStatus {}

class DeleteCommentInitial extends DeleteCommentStatus {}

class DeleteCommentLoading extends DeleteCommentStatus {}

class DeleteCommentSuccess extends DeleteCommentStatus {
  final dynamic result;
  DeleteCommentSuccess({required this.result});
}

class DeleteCommentError extends DeleteCommentStatus {
  final String error;
  DeleteCommentError({required this.error});
}
