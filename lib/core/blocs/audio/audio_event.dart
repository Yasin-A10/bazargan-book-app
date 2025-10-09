part of 'audio_bloc.dart';

abstract class AudioEvent {}

class PlayAudio extends AudioEvent {
  final String url;
  final String title;
  final String image;

  PlayAudio({required this.url, required this.title, required this.image});
}

class PauseAudio extends AudioEvent {}

class StopAudio extends AudioEvent {}

class ToggleAudio extends AudioEvent {}
