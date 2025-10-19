part of 'audio_bloc.dart';

class AudioState extends Equatable {
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final String? currentUrl;
  final double playbackSpeed;

  const AudioState({
    this.isPlaying = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.currentUrl,
    this.playbackSpeed = 1.0,
  });

  AudioState copyWith({
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    String? currentUrl,
    double? playbackSpeed,
  }) {
    return AudioState(
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      currentUrl: currentUrl ?? this.currentUrl,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
    );
  }

  @override
  List<Object?> get props => [
    isPlaying,
    position,
    duration,
    currentUrl,
    playbackSpeed,
  ];
}

class AudioInitial extends AudioState {}
