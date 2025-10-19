part of 'audio_book_bloc.dart';

@immutable
abstract class AudioBookState {}

class AudioBookInitial extends AudioBookState {}

class AudioBookLoading extends AudioBookState {}

class AudioBookSuccess extends AudioBookState {
  final List<AudioBookModel> audioBooks;

  AudioBookSuccess({required this.audioBooks});
}

class AudioBookError extends AudioBookState {
  final String message;

  AudioBookError({required this.message});
}
