import 'dart:math' as math;
import 'dart:ui';

import 'package:bazargan/core/blocs/audio/audio_bloc.dart';
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
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

class AudioBookScreen extends StatefulWidget {
  final int childBookId;

  const AudioBookScreen({super.key, required this.childBookId});

  @override
  State<AudioBookScreen> createState() => _AudioBookScreenState();
}

class _AudioBookScreenState extends State<AudioBookScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  List<AudioBookModel> _audioBooks = [];
  int _currentIndex = 0;

  final List<double> _speeds = [1, 1.25, 1.5, 1.75, 2];

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

    BlocProvider.of<AudioBookBloc>(
      context,
    ).add(LoadAudioBookLinks(childBookId: widget.childBookId));
  }

  Future<void> _playChapter(int index) async {
    final chapter = _audioBooks[index];
    final url = '${chapter.mediaLink?.file}?token=${chapter.mediaLink?.token}';
    context.read<AudioBloc>().add(
      PlayAudioEvent(url: url, title: chapter.name, imageUrl: chapter.bookPic),
    );
    setState(() => _currentIndex = index);
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'سرعت پخش',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  children: _speeds.map((speed) {
                    return ElevatedButton(
                      onPressed: () {
                        // locator<AudioBloc>().setPlaybackSpeed(speed);
                        context.read<AudioBloc>().setPlaybackSpeed(speed);
                        context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryTint8,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
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
            if (_audioBooks.isEmpty ||
                _audioBooks.first.id != state.audioBooks.first.id) {
              _audioBooks = state.audioBooks;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final url =
                    '${_audioBooks.first.mediaLink?.file}?token=${_audioBooks.first.mediaLink?.token}';
                locator<AudioBloc>().add(
                  PlayAudioEvent(
                    url: url,
                    title: _audioBooks.first.name,
                    imageUrl: _audioBooks.first.bookPic,
                  ),
                );
              });
            }

            return BlocBuilder<AudioBloc, AudioState>(
              builder: (context, audioState) {
                return SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 400,
                            width: double.infinity,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: _audioBooks.first.bookPic!,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: LoadingAnimationWidget.flickr(
                                      leftDotColor: AppColors.primary,
                                      rightDotColor: AppColors.secondary,
                                      size: 50,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        AppColors.white.withOpacity(0.7),
                                        AppColors.white.withOpacity(0.9),
                                        AppColors.white,
                                      ],
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: _audioBooks.first.bookPic!,
                                  height: 250,
                                  width: 250,
                                  fit: BoxFit.cover,
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _audioBooks[_currentIndex].name!,
                        style: AppTextStyles.headlineLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
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
                        children: [
                          const Icon(
                            Iconsax.microphone_2_copy,
                            color: AppColors.neutralMidnight,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _audioBooks.first.narrator ?? 'نام گوینده',
                            style: AppTextStyles.small.copyWith(
                              color: AppColors.neutralMidnight,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // 🎚️ Seek bar
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Slider(
                                  min: 0.0,
                                  value: audioState.position.inSeconds
                                      .toDouble(),
                                  max:
                                      audioState.duration.inSeconds.toDouble() >
                                          0
                                      ? audioState.duration.inSeconds.toDouble()
                                      : 1,
                                  onChanged: (value) {
                                    context.read<AudioBloc>().add(
                                      SeekAudioEvent(
                                        Duration(seconds: value.toInt()),
                                      ),
                                    );
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
                                    _formatDuration(audioState.duration),
                                  ),
                                  style: AppTextStyles.small,
                                ),
                                Text(
                                  formatNumberToPersianWithoutSeparator(
                                    _formatDuration(audioState.position),
                                  ),
                                  style: AppTextStyles.small,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // 🎧 کنترل‌ها
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: _showChaptersModal,
                            icon: const Icon(Iconsax.menu_1_copy),
                          ),
                          IconButton(
                            icon: const Icon(Iconsax.backward_5_seconds_copy),
                            onPressed: () {
                              final newPos =
                                  audioState.position -
                                  const Duration(seconds: 5);
                              context.read<AudioBloc>().add(
                                SeekAudioEvent(newPos),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              audioState.isPlaying
                                  ? Iconsax.pause
                                  : Iconsax.play,
                              color: AppColors.primary,
                              size: 36,
                            ),
                            onPressed: () {
                              if (audioState.isPlaying) {
                                context.read<AudioBloc>().add(
                                  PauseAudioEvent(),
                                );
                              } else {
                                final currentUrl =
                                    audioState.currentUrl ??
                                    '${_audioBooks[_currentIndex].mediaLink?.file}?token=${_audioBooks[_currentIndex].mediaLink?.token}';
                                context.read<AudioBloc>().add(
                                  PlayAudioEvent(
                                    url: currentUrl,
                                    title: _audioBooks[_currentIndex].name,
                                    imageUrl:
                                        _audioBooks[_currentIndex].bookPic,
                                  ),
                                );
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Iconsax.forward_5_seconds_copy),
                            onPressed: () {
                              final newPos =
                                  audioState.position +
                                  const Duration(seconds: 5);
                              context.read<AudioBloc>().add(
                                SeekAudioEvent(newPos),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Iconsax.speedometer_copy),
                            onPressed: _showSpeedModal,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                );
              },
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
