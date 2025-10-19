part of 'audio_bloc.dart';

@immutable
abstract class AudioEvent {}

class PlayAudio extends AudioEvent {
  final String url;
  final String title;
  final String image;

  PlayAudio({required this.url, required this.title, required this.image});
}

class PauseAudio extends AudioEvent {}

class ToggleAudio extends AudioEvent {}

class StopAudio extends AudioEvent {}

class SeekAudio extends AudioEvent {
  final Duration position;
  SeekAudio(this.position);
}

class UpdatePosition extends AudioEvent {
  final Duration position;
  UpdatePosition(this.position);
}

// part of 'audio_bloc.dart';

// @immutable
// abstract class AudioEvent {}

// // پخش فایل صوتی جدید
// class PlayAudio extends AudioEvent {
//   final String url;
//   final String title;
//   final String image;

//   PlayAudio({
//     required this.url,
//     required this.title,
//     required this.image,
//   });
// }

// // توقف موقت
// class PauseAudio extends AudioEvent {}

// // ادامه پخش
// class ResumeAudio extends AudioEvent {}

// // تغییر وضعیت بین پخش و توقف موقت
// class TogglePlayPause extends AudioEvent {}

// // توقف کامل و پاکسازی
// class StopAudio extends AudioEvent {}

// // رفتن به موقعیت مشخص
// class SeekAudio extends AudioEvent {
//   final Duration position;
//   SeekAudio(this.position);
// }

// // جلو رفتن ۵ ثانیه
// class SeekForward extends AudioEvent {}

// // عقب رفتن ۵ ثانیه
// class SeekBackward extends AudioEvent {}

// // به‌روزرسانی موقعیت (استفاده داخلی توسط Stream)
// class UpdatePosition extends AudioEvent {
//   final Duration position;
//   final Duration duration;

//   UpdatePosition({
//     required this.position,
//     required this.duration,
//   });
// }

// // اتمام پخش فایل
// class AudioCompleted extends AudioEvent {}
