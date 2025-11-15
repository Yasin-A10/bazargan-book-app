import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioPlayer _player = AudioPlayer();
  StreamSubscription? _positionSub;
  StreamSubscription? _durationSub;
  StreamSubscription? _stateSub;

  AudioBloc() : super(AudioInitial()) {
    on<PlayAudioEvent>(_onPlayAudio);
    on<PauseAudioEvent>(_onPauseAudio);
    on<SeekAudioEvent>(_onSeekAudio);
    on<UpdateAudioStatusEvent>(_onUpdateAudioStatus);
    on<StopAudioEvent>(_onStopAudio);

    // Listen to player streams
    _positionSub = _player.positionStream.listen((pos) {
      add(UpdateAudioStatusEvent(position: pos));
    });
    _durationSub = _player.durationStream.listen((dur) {
      add(UpdateAudioStatusEvent(duration: dur ?? Duration.zero));
    });
    _stateSub = _player.playerStateStream.listen((state) {
      add(UpdateAudioStatusEvent(isPlaying: state.playing));
    });
  }

  Future<void> _onPlayAudio(
    PlayAudioEvent event,
    Emitter<AudioState> emit,
  ) async {
    // if url is not the same as the current url, set it
    if (event.url != state.currentUrl) {
      await _player.setUrl(event.url);
      emit(
        state.copyWith(
          currentUrl: event.url,
          currentTitle: event.title,
          currentImageUrl: event.imageUrl,
        ),
      );
    }
    await _player.play();
    emit(state.copyWith(isPlaying: true));
  }

  Future<void> _onStopAudio(
    StopAudioEvent event,
    Emitter<AudioState> emit,
  ) async {
    await _player.stop();
    emit(const AudioState()); // reset to initial state
  }

  Future<void> _onPauseAudio(
    PauseAudioEvent event,
    Emitter<AudioState> emit,
  ) async {
    await _player.pause();
    emit(state.copyWith(isPlaying: false));
  }

  Future<void> _onSeekAudio(
    SeekAudioEvent event,
    Emitter<AudioState> emit,
  ) async {
    await _player.seek(event.position);
    emit(state.copyWith(position: event.position));
  }

  void _onUpdateAudioStatus(
    UpdateAudioStatusEvent event,
    Emitter<AudioState> emit,
  ) {
    emit(
      state.copyWith(
        position: event.position ?? state.position,
        duration: event.duration ?? state.duration,
        isPlaying: event.isPlaying ?? state.isPlaying,
      ),
    );
  }

  Future<void> setPlaybackSpeed(double speed) async {
    await _player.setSpeed(speed);
  }

  @override
  Future<void> close() {
    _positionSub?.cancel();
    _durationSub?.cancel();
    _stateSub?.cancel();
    _player.dispose();
    return super.close();
  }
}
