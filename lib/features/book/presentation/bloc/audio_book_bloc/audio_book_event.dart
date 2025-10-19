part of 'audio_book_bloc.dart';

abstract class AudioBookEvent {}

class LoadAudioBookLinks extends AudioBookEvent {
  final int childBookId;

  LoadAudioBookLinks({required this.childBookId});
}
