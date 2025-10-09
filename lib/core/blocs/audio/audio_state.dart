part of 'audio_bloc.dart';

@immutable
abstract class AudioState {}

class AudioInitial extends AudioState {}

class AudioPlaying extends AudioState {
  final String title;
  final String image;

  AudioPlaying({required this.title, required this.image});
}

class AudioPaused extends AudioState {
  final String title;
  final String image;

  AudioPaused({required this.title, required this.image});
}

class AudioStopped extends AudioState {}
