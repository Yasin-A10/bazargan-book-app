import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioPlayer _player = AudioPlayer();

  AudioBloc() : super(AudioInitial()) {
    // شروع پخش
    on<PlayAudio>((event, emit) async {
      try {
        await _player.setUrl(event.url);
        _player.play();

        emit(
          AudioPlaying(
            title: event.title,
            image: event.image,
            position: Duration.zero,
            duration: _player.duration ?? Duration.zero,
          ),
        );

        // گوش دادن به تغییر زمان پخش
        _player.positionStream.listen((pos) {
          if (state is AudioPlaying) {
            add(UpdatePosition(pos));
          }
        });

        // گوش دادن به پایان پخش
        _player.playerStateStream.listen((stateStream) {
          if (stateStream.processingState == ProcessingState.completed) {
            add(StopAudio());
          }
        });
      } catch (e) {
        emit(AudioError(message: 'خطا در پخش صدا: $e'));
      }
    });

    // توقف پخش
    on<StopAudio>((event, emit) async {
      await _player.stop();
      emit(AudioStopped());
    });

    // مکث
    on<PauseAudio>((event, emit) async {
      await _player.pause();
      if (state is AudioPlaying) {
        emit(
          AudioPaused(
            title: (state as AudioPlaying).title,
            image: (state as AudioPlaying).image,
            position: (state as AudioPlaying).position,
            duration: (state as AudioPlaying).duration,
          ),
        );
      }
    });

    // ادامه پخش
    on<ToggleAudio>((event, emit) async {
      if (_player.playing) {
        add(PauseAudio());
      } else if (state is AudioPaused) {
        await _player.play();
        emit(
          AudioPlaying(
            title: (state as AudioPaused).title,
            image: (state as AudioPaused).image,
            position: (state as AudioPaused).position,
            duration: (state as AudioPaused).duration,
          ),
        );
      }
    });

    // Seek
    on<SeekAudio>((event, emit) async {
      await _player.seek(event.position);
    });

    // آپدیت زمان
    on<UpdatePosition>((event, emit) {
      if (state is AudioPlaying) {
        emit(
          AudioPlaying(
            title: (state as AudioPlaying).title,
            image: (state as AudioPlaying).image,
            position: event.position,
            duration: (state as AudioPlaying).duration,
          ),
        );
      }
    });
  }

  @override
  Future<void> close() {
    _player.dispose();
    return super.close();
  }
}

// import 'dart:async';
// import 'package:bazargan/core/utils/audio_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:just_audio/just_audio.dart';

// part 'audio_event.dart';
// part 'audio_state.dart';

// class AudioBloc extends Bloc<AudioEvent, AudioState> {
//   final AudioPlayerManager _audioManager;
//   StreamSubscription<Duration>? _positionSubscription;
//   StreamSubscription<Duration?>? _durationSubscription;
//   StreamSubscription<ProcessingState>? _processingStateSubscription;

//   AudioBloc(this._audioManager) : super(AudioInitial()) {
//     // Event handlers
//     on<PlayAudio>(_onPlayAudio);
//     on<PauseAudio>(_onPauseAudio);
//     on<ResumeAudio>(_onResumeAudio);
//     on<TogglePlayPause>(_onTogglePlayPause);
//     on<StopAudio>(_onStopAudio);
//     on<SeekAudio>(_onSeekAudio);
//     on<SeekForward>(_onSeekForward);
//     on<SeekBackward>(_onSeekBackward);
//     on<UpdatePosition>(_onUpdatePosition);
//     on<AudioCompleted>(_onAudioCompleted);
//   }

//   /// پخش فایل صوتی جدید
//   Future<void> _onPlayAudio(
//     PlayAudio event,
//     Emitter<AudioState> emit,
//   ) async {
//     try {
//       // نمایش حالت بارگذاری
//       emit(AudioLoading(title: event.title, image: event.image));

//       // توقف پخش قبلی
//       await _audioManager.stop();
//       await _cancelSubscriptions();

//       // تنظیم فایل جدید
//       await _audioManager.setAudioSource(event.url);

//       // شروع پخش
//       await _audioManager.play();

//       // دریافت مدت کل (ممکن است هنوز null باشد)
//       final duration = _audioManager.duration ?? Duration.zero;

//       // emit state اولیه
//       emit(AudioPlaying(
//         title: event.title,
//         image: event.image,
//         position: Duration.zero,
//         duration: duration,
//       ));

//       // شروع listening به streamها
//       _startListening();
//     } catch (e) {
//       debugPrint('❌ خطا در پخش صدا: $e');
//       emit(AudioError(message: 'خطا در پخش فایل صوتی: $e'));
//     }
//   }

//   /// توقف موقت
//   Future<void> _onPauseAudio(
//     PauseAudio event,
//     Emitter<AudioState> emit,
//   ) async {
//     if (state is AudioPlaying) {
//       await _audioManager.pause();
//       final currentState = state as AudioPlaying;
//       emit(AudioPaused(
//         title: currentState.title,
//         image: currentState.image,
//         position: _audioManager.position,
//         duration: currentState.duration,
//       ));
//     }
//   }

//   /// ادامه پخش
//   Future<void> _onResumeAudio(
//     ResumeAudio event,
//     Emitter<AudioState> emit,
//   ) async {
//     if (state is AudioPaused) {
//       await _audioManager.play();
//       final currentState = state as AudioPaused;
//       emit(AudioPlaying(
//         title: currentState.title,
//         image: currentState.image,
//         position: currentState.position,
//         duration: currentState.duration,
//       ));
//     }
//   }

//   /// تغییر وضعیت پخش
//   Future<void> _onTogglePlayPause(
//     TogglePlayPause event,
//     Emitter<AudioState> emit,
//   ) async {
//     if (state is AudioPlaying) {
//       add(PauseAudio());
//     } else if (state is AudioPaused) {
//       add(ResumeAudio());
//     }
//   }

//   /// توقف کامل
//   Future<void> _onStopAudio(
//     StopAudio event,
//     Emitter<AudioState> emit,
//   ) async {
//     await _audioManager.stop();
//     await _cancelSubscriptions();
//     emit(AudioStopped());
//   }

//   /// رفتن به موقعیت مشخص
//   Future<void> _onSeekAudio(
//     SeekAudio event,
//     Emitter<AudioState> emit,
//   ) async {
//     await _audioManager.seek(event.position);

//     // به‌روزرسانی state بدون تغییر وضعیت پخش
//     if (state is AudioPlaying) {
//       final currentState = state as AudioPlaying;
//       emit(currentState.copyWith(position: event.position));
//     } else if (state is AudioPaused) {
//       final currentState = state as AudioPaused;
//       emit(currentState.copyWith(position: event.position));
//     }
//   }

//   /// جلو رفتن ۵ ثانیه
//   Future<void> _onSeekForward(
//     SeekForward event,
//     Emitter<AudioState> emit,
//   ) async {
//     final currentPosition = _audioManager.position;
//     final duration = _audioManager.duration ?? Duration.zero;
//     final newPosition = currentPosition + const Duration(seconds: 5);

//     if (newPosition < duration) {
//       await _audioManager.seek(newPosition);
//     } else {
//       await _audioManager.seek(duration);
//     }

//     // state به‌روزرسانی می‌شود از طریق stream
//   }

//   /// عقب رفتن ۵ ثانیه
//   Future<void> _onSeekBackward(
//     SeekBackward event,
//     Emitter<AudioState> emit,
//   ) async {
//     final currentPosition = _audioManager.position;
//     final newPosition = currentPosition - const Duration(seconds: 5);

//     if (newPosition > Duration.zero) {
//       await _audioManager.seek(newPosition);
//     } else {
//       await _audioManager.seek(Duration.zero);
//     }

//     // state به‌روزرسانی می‌شود از طریق stream
//   }

//   /// به‌روزرسانی موقعیت از stream
//   void _onUpdatePosition(
//     UpdatePosition event,
//     Emitter<AudioState> emit,
//   ) {
//     if (state is AudioPlaying) {
//       final currentState = state as AudioPlaying;
//       emit(currentState.copyWith(
//         position: event.position,
//         duration: event.duration,
//       ));
//     }
//   }

//   /// اتمام پخش
//   Future<void> _onAudioCompleted(
//     AudioCompleted event,
//     Emitter<AudioState> emit,
//   ) async {
//     if (state is AudioPlaying) {
//       final currentState = state as AudioPlaying;
//       // نمایش موقعیت در انتها
//       emit(currentState.copyWith(
//         position: currentState.duration,
//       ));
//       // می‌توانید اینجا به AudioStopped برگردید یا همینجا بمانید
//       // emit(AudioStopped());
//     }
//   }

//   /// شروع listening به streamها
//   void _startListening() {
//     // گوش دادن به position
//     _positionSubscription = _audioManager.positionStream.listen((position) {
//       final duration = _audioManager.duration ?? Duration.zero;
//       add(UpdatePosition(position: position, duration: duration));
//     });

//     // گوش دادن به duration (برای وقتی که بعداً بارگذاری می‌شود)
//     _durationSubscription = _audioManager.durationStream.listen((duration) {
//       if (duration != null && state is AudioPlaying) {
//         final currentState = state as AudioPlaying;
//         add(UpdatePosition(
//           position: currentState.position,
//           duration: duration,
//         ));
//       }
//     });

//     // گوش دادن به اتمام پخش
//     _processingStateSubscription =
//         _audioManager.processingStateStream.listen((processingState) {
//       if (processingState == ProcessingState.completed) {
//         add(AudioCompleted());
//       }
//     });
//   }

//   /// لغو تمام subscriptionها
//   Future<void> _cancelSubscriptions() async {
//     await _positionSubscription?.cancel();
//     await _durationSubscription?.cancel();
//     await _processingStateSubscription?.cancel();
//     _positionSubscription = null;
//     _durationSubscription = null;
//     _processingStateSubscription = null;
//   }

//   @override
//   Future<void> close() async {
//     await _cancelSubscriptions();
//     _audioManager.dispose();
//     return super.close();
//   }
// }
