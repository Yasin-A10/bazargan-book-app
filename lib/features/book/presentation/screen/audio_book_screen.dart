import 'dart:ui';
import 'dart:math' as math;

import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/utils/number_formater.dart';
import 'package:bazargan/features/book/data/model/audio_book_model.dart';
import 'package:bazargan/features/book/presentation/bloc/audio_book_bloc/audio_book_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class AudioBookScreen extends StatefulWidget {
  final int childBookId;

  const AudioBookScreen({super.key, required this.childBookId});

  @override
  State<AudioBookScreen> createState() => _AudioBookScreen();
}

class _AudioBookScreen extends State<AudioBookScreen> {
  final AudioPlayer _player = AudioPlayer();

  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  List<AudioBookModel> _audioBooks = [];
  int _currentIndex = 0;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isPlaying = false;
  final List<double> _speeds = [1, 1.25, 1.5, 1.75, 2];

  StreamSubscription? _positionSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _playerStateSubscription;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset > 40 && !_isScrolled) {
        setState(() => _isScrolled = true);
      } else if (_scrollController.offset <= 40 && _isScrolled) {
        setState(() => _isScrolled = false);
      }
    });

    // Load the audio books
    BlocProvider.of<AudioBookBloc>(
      context,
    ).add(LoadAudioBookLinks(childBookId: widget.childBookId));

    // Set up player listeners
    _positionSubscription = _player.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _position = position;
        });
      }
    });

    _durationSubscription = _player.durationStream.listen((duration) {
      if (mounted) {
        setState(() {
          _duration = duration ?? Duration.zero;
        });
      }
    });

    _playerStateSubscription = _player.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state.playing;
        });
      }
    });
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _playerStateSubscription?.cancel();
    _player.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _playChapter(int index) async {
    final chapter = _audioBooks[index];
    final url = '${chapter.mediaLink?.file}?token=${chapter.mediaLink?.token}';
    await _player.setUrl(url);
    await _player.play();
    setState(() {
      _currentIndex = index;
    });
  }

  void _showChaptersModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: _audioBooks.length,
          itemBuilder: (context, index) {
            final chapter = _audioBooks[index];
            return ListTile(
              title: Text(chapter.name!),
              selected: index == _currentIndex,
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
                _playChapter(index);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  void _showSpeedModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('سرعت پخش'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 8,
                  children: _speeds.map((speed) {
                    return ElevatedButton(
                      onPressed: () {
                        _player.setSpeed(speed);
                        context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        minimumSize: const Size(0, 32),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: AppColors.secondaryTint8,
                      ),
                      child: Text(
                        formatNumberToPersianWithoutSeparator(speed.toString()),
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shape: LinearBorder.bottom(
          side: BorderSide(
            color: !_isScrolled ? Colors.transparent : AppColors.neutralEDEDED,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: _isScrolled ? Colors.white : Colors.transparent,
        ),
        title: Text('پخش کتاب صوتی', style: AppTextStyles.headlineLarge),
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_right_1_copy,
            color: AppColors.neutral353535,
            size: 16,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<AudioBookBloc, AudioBookState>(
        builder: (context, state) {
          if (state is AudioBookLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AudioBookSuccess) {
            if (_audioBooks.isEmpty) {
              _audioBooks = state.audioBooks;
              // Play first chapter on initial load
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_audioBooks.isNotEmpty) {
                  _playChapter(0);
                }
              });
            }
            return SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: 0,
                                sigmaY: 0,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: _audioBooks.first.bookPic!,
                                fit: BoxFit.cover,
                                fadeInDuration: const Duration(
                                  microseconds: 300,
                                ),
                                placeholder: (context, url) => Center(
                                  child: LoadingAnimationWidget.flickr(
                                    leftDotColor: AppColors.primary,
                                    rightDotColor: AppColors.secondary,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColors.white.withValues(alpha: 0.7),
                                    AppColors.white.withValues(alpha: 0.9),
                                    AppColors.white.withValues(alpha: 1.0),
                                  ],
                                  stops: const [0.0, 0.6, 1.0],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 140,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Column(
                            spacing: 8,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.3,
                                      ),
                                      blurRadius: 10.8,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: _audioBooks.first.bookPic!,
                                    height: 250,
                                    width: 250,
                                    fit: BoxFit.cover,
                                    fadeInDuration: const Duration(
                                      microseconds: 300,
                                    ),
                                    placeholder: (context, url) => Center(
                                      child: LoadingAnimationWidget.flickr(
                                        leftDotColor: AppColors.primary,
                                        rightDotColor: AppColors.secondary,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _audioBooks[_currentIndex].name!,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.headlineLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${formatNumberToPersian(_currentIndex + 1)} از ${formatNumberToPersian(_audioBooks.length)}',
                    style: AppTextStyles.small.copyWith(
                      color: AppColors.neutralMidnight,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.microphone_2_copy,
                        color: AppColors.neutralMidnight,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _audioBooks.first.narrator ?? 'نام گوینده',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.small.copyWith(
                          color: AppColors.neutralMidnight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Seek bar
                  Column(
                    children: [
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 2,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 8,
                            ),
                            overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 14,
                            ),
                            activeTrackColor: AppColors.secondary,
                            inactiveTrackColor: AppColors.neutralE3E3E3,
                            thumbColor: AppColors.secondary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Slider(
                              min: 0.0,
                              value: _position.inSeconds.toDouble(),
                              max: _duration.inSeconds.toDouble(),
                              onChanged: (value) {
                                _player.seek(Duration(seconds: value.toInt()));
                              },
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatNumberToPersianWithoutSeparator(
                                _formatDuration(_duration),
                              ),
                              style: AppTextStyles.small,
                            ),
                            Text(
                              formatNumberToPersianWithoutSeparator(
                                _formatDuration(_position),
                              ),
                              style: AppTextStyles.small,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          _showChaptersModal();
                        },
                        icon: Icon(Iconsax.menu_1_copy),
                      ),
                      IconButton(
                        icon: const Icon(Iconsax.backward_5_seconds_copy),
                        onPressed: () {
                          final newPosition =
                              _position + const Duration(seconds: 5);
                          _player.seek(
                            newPosition > _duration ? _duration : newPosition,
                          );
                        },
                      ),

                      IconButton(
                        icon: Icon(
                          _isPlaying ? Iconsax.pause : Iconsax.play,
                          color: AppColors.primary,
                          size: 36,
                        ),
                        onPressed: () {
                          if (_isPlaying) {
                            _player.pause();
                          } else {
                            _player.play();
                          }
                        },
                      ),

                      IconButton(
                        icon: const Icon(Iconsax.forward_5_seconds_copy),
                        onPressed: () {
                          final newPosition =
                              _position - const Duration(seconds: 5);
                          _player.seek(
                            newPosition < Duration.zero
                                ? Duration.zero
                                : newPosition,
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Iconsax.speedometer_copy),
                        onPressed: () {
                          _showSpeedModal();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else if (state is AudioBookError) {
            return Center(child: Text('خطا: ${state.message}'));
          } else {
            return const Center(child: Text('لطفاً منتظر بمانید'));
          }
        },
      ),
    );
  }
}
