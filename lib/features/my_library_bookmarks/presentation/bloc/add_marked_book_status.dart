import 'package:flutter/widgets.dart';

@immutable
abstract class AddMarkedBookStatus {}

class AddMarkedBookInitial extends AddMarkedBookStatus {}

class AddMarkedBookLoading extends AddMarkedBookStatus {}

class AddMarkedBookSuccess extends AddMarkedBookStatus {
  final Map<String, dynamic> bookmark;

  AddMarkedBookSuccess({required this.bookmark});
}

class AddMarkedBookError extends AddMarkedBookStatus {
  final String error;

  AddMarkedBookError({required this.error});
}
