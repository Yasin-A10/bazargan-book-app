part of 'book_file_bloc.dart';

@immutable
abstract class BookFileState {}

class BookFileInitial extends BookFileState {}

class BookFileLoading extends BookFileState {}

class BookFileProgress extends BookFileState {
  final double progress;

  BookFileProgress({required this.progress});
}

class BookFileLoaded extends BookFileState {
  final dynamic file;

  BookFileLoaded({required this.file});
}

class BookFileError extends BookFileState {
  final String error;

  BookFileError({required this.error});
}
