part of 'audio_bloc.dart';

@immutable
abstract class AudioState {}

class AudioInitial extends AudioState {}

class AudioPlaying extends AudioState {
  final String title;
  final String image;
  final Duration position;
  final Duration duration;

  AudioPlaying({
    required this.title,
    required this.image,
    required this.position,
    required this.duration,
  });
}

class AudioPaused extends AudioState {
  final String title;
  final String image;
  final Duration position;
  final Duration duration;

  AudioPaused({
    required this.title,
    required this.image,
    required this.position,
    required this.duration,
  });
}

class AudioStopped extends AudioState {}

class AudioError extends AudioState {
  final String message;
  AudioError({required this.message});
}
