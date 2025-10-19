part of 'audio_bloc.dart';

abstract class AudioEvent extends Equatable {
  const AudioEvent();
  @override
  List<Object?> get props => [];
}

class PlayAudioEvent extends AudioEvent {
  final String url;
  final String? title;
  final String? imageUrl;
  const PlayAudioEvent({required this.url, this.title, this.imageUrl});
}

class PauseAudioEvent extends AudioEvent {}

class SeekAudioEvent extends AudioEvent {
  final Duration position;
  const SeekAudioEvent(this.position);
}

class UpdateAudioStatusEvent extends AudioEvent {
  final Duration? position;
  final Duration? duration;
  final bool? isPlaying;
  final double? playbackSpeed;
  const UpdateAudioStatusEvent({
    this.position,
    this.duration,
    this.isPlaying,
    this.playbackSpeed,
  });
}

class StopAudioEvent extends AudioEvent {}
