part of 'book_file_bloc.dart';

@immutable
abstract class BookFileState {}

class BookFileInitial extends BookFileState {}

class BookFileLoading extends BookFileState {
  final int bookId;

  BookFileLoading({required this.bookId});
}

class BookFileProgress extends BookFileState {
  final double progress;

  BookFileProgress({required this.progress});
}

class BookFileLoaded extends BookFileState {
  final int bookId;
  final dynamic file;

  BookFileLoaded({required this.bookId, required this.file});
}

class BookFileError extends BookFileState {
  final String error;

  BookFileError({required this.error});
}
