import 'package:flutter/material.dart';

@immutable
abstract class DeleteCartStatus {}

class DeleteCartInitial extends DeleteCartStatus {}

class DeleteCartLoading extends DeleteCartStatus {}

class DeleteCartSuccess extends DeleteCartStatus {
  final dynamic result;
  DeleteCartSuccess({required this.result});
}

class DeleteCartError extends DeleteCartStatus {
  final String error;
  DeleteCartError({required this.error});
}
