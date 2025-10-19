import 'package:bazargan/features/my_library/data/models/my_library_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoadMyBooksStatus {}

class MyLibraryInitial extends LoadMyBooksStatus {}

class MyLibraryLoading extends LoadMyBooksStatus {}

class MyLibrarySuccess extends LoadMyBooksStatus {
  final MyLibraryModel myLibraryModel;
  MyLibrarySuccess({required this.myLibraryModel});
}

class MyLibraryError extends LoadMyBooksStatus {
  final String error;
  MyLibraryError({required this.error});
}
