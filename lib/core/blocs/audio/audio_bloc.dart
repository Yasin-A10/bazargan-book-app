import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioPlayer _player = AudioPlayer();

  AudioBloc() : super(AudioInitial()) {
    on<PlayAudio>((event, emit) async {
      try {
        await _player.setUrl(event.url);
        _player.play();
        emit(AudioPlaying(title: event.title, image: event.image));
      } catch (e) {
        print("Error playing audio: $e");
      }
    });

    on<PauseAudio>((event, emit) {
      _player.pause();
      if (state is AudioPlaying) {
        emit(
          AudioPaused(
            title: (state as AudioPlaying).title,
            image: (state as AudioPlaying).image,
          ),
        );
      }
    });

    on<ToggleAudio>((event, emit) {
      if (_player.playing) {
        add(PauseAudio());
      } else if (state is AudioPaused) {
        _player.play();
        emit(
          AudioPlaying(
            title: (state as AudioPaused).title,
            image: (state as AudioPaused).image,
          ),
        );
      }
    });

    on<StopAudio>((event, emit) {
      _player.stop();
      emit(AudioStopped());
    });
  }

  @override
  Future<void> close() {
    _player.dispose();
    return super.close();
  }
}
