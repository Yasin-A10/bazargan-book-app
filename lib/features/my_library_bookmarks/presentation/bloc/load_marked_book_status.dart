import 'package:bazargan/features/my_library_bookmarks/data/model/marked_books_model.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class LoadMarkedBooksStatus {}

class MarkedBooksInitial extends LoadMarkedBooksStatus {}

class MarkedBooksLoading extends LoadMarkedBooksStatus {}

class MarkedBooksSuccess extends LoadMarkedBooksStatus {
  final MarkedBooksModel markedBooksModel;

  MarkedBooksSuccess({required this.markedBooksModel});
}

class MarkedBooksError extends LoadMarkedBooksStatus {
  final String error;

  MarkedBooksError({required this.error});
}
