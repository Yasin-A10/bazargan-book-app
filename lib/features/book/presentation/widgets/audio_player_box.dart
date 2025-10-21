import 'package:bazargan/core/blocs/audio/audio_bloc.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        if (state.currentUrl == null) {
          return const SizedBox.shrink();
        }

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl: state.currentImageUrl ?? '',
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: LoadingAnimationWidget.flickr(
                        leftDotColor: AppColors.primary,
                        rightDotColor: AppColors.secondary,
                        size: 20,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    state.currentTitle ?? 'صوت ناشناخته',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: Icon(
                    state.isPlaying ? Iconsax.pause : Iconsax.play,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    if (state.isPlaying) {
                      context.read<AudioBloc>().add(PauseAudioEvent());
                    } else {
                      context.read<AudioBloc>().add(
                        PlayAudioEvent(
                          url: state.currentUrl!,
                          title: state.currentTitle!,
                          imageUrl: state.currentImageUrl!,
                        ),
                      );
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Iconsax.close_square_copy,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    context.read<AudioBloc>().add(StopAudioEvent());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
