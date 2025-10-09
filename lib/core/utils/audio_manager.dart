import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

class AudioPlayerManager extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  String? currentTitle;
  String? currentImage;

  AudioPlayer get player => _audioPlayer;

  Future<void> play(String url, {String? title, String? image}) async {
    currentTitle = title;
    currentImage = image;

    try {
      await _audioPlayer.setUrl(url);
      _audioPlayer.play();
      isPlaying = true;
      notifyListeners();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  void pause() {
    _audioPlayer.pause();
    isPlaying = false;
    notifyListeners();
  }

  void stop() {
    _audioPlayer.stop();
    isPlaying = false;
    currentTitle = null;
    currentImage = null;
    notifyListeners();
  }

  void togglePlayPause() {
    if (_audioPlayer.playing) {
      pause();
    } else {
      _audioPlayer.play();
      isPlaying = true;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
