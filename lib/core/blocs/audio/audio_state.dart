part of 'audio_bloc.dart';

class AudioState extends Equatable {
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final String? currentUrl;
  final double playbackSpeed;
  final String? currentTitle;
  final String? currentImageUrl;

  const AudioState({
    this.isPlaying = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.currentUrl,
    this.playbackSpeed = 1.0,
    this.currentTitle,
    this.currentImageUrl,
  });

  AudioState copyWith({
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    String? currentUrl,
    double? playbackSpeed,
    String? currentTitle,
    String? currentImageUrl,
  }) {
    return AudioState(
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      currentUrl: currentUrl ?? this.currentUrl,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      currentTitle: currentTitle ?? this.currentTitle,
      currentImageUrl: currentImageUrl ?? this.currentImageUrl,
    );
  }

  @override
  List<Object?> get props => [
    isPlaying,
    position,
    duration,
    currentUrl,
    playbackSpeed,
    currentTitle,
    currentImageUrl,
  ];
}

class AudioInitial extends AudioState {}
