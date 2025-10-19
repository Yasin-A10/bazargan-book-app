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
          return const SizedBox.shrink(); // اگر چیزی پخش نمی‌شه، نشون نده
        }

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // تصویر در سمت راست (چون rtl، سمت راست صفحه)
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
                // عنوان
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
                // دکمه‌ها در سمت چپ (چون rtl، سمت چپ صفحه)
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

// import 'package:bazargan/core/blocs/audio/audio_bloc.dart';
// import 'package:bazargan/core/constants/colors.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';

// class AudioPlayerBox extends StatelessWidget {
//   const AudioPlayerBox({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AudioBloc, AudioState>(
//       builder: (context, state) {
//         if (state is AudioInitial || state is AudioStopped) {
//           return SizedBox.shrink();
//         }

//         String title = '';
//         String image = '';
//         bool isPlaying = false;

//         if (state is AudioPlaying) {
//           title = state.title;
//           image = state.image;
//           isPlaying = true;
//         } else if (state is AudioPaused) {
//           title = state.title;
//           image = state.image;
//           isPlaying = false;
//         }

//         return Align(
//           alignment: Alignment.bottomCenter,
//           child: Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 height: 60,
//                 padding: const EdgeInsets.only(
//                   right: 66,
//                   left: 8,
//                   bottom: 12,
//                   top: 8,
//                 ),
//                 decoration: BoxDecoration(
//                   color: AppColors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.neutralMidnight.withValues(alpha: 0.1),
//                       blurRadius: 10,
//                       spreadRadius: 2,
//                       offset: const Offset(0, 0),
//                     ),
//                   ],
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(16),
//                     topRight: Radius.circular(16),
//                   ),
//                   shape: BoxShape.rectangle,
//                 ),
//                 child: Row(
//                   children: [
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Row(
//                         children: [
//                           IconButton(
//                             constraints: BoxConstraints(),
//                             padding: EdgeInsets.zero,
//                             onPressed: () =>
//                                 context.read<AudioBloc>().add(ToggleAudio()),
//                             icon: Icon(
//                               isPlaying ? Iconsax.pause : Iconsax.play,
//                               color: AppColors.primary,
//                               size: 32,
//                             ),
//                           ),
//                           Text(
//                             title,
//                             style: TextStyle(color: AppColors.neutralMidnight),
//                             maxLines: 1,
//                             textAlign: TextAlign.right,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ),

//                     IconButton(
//                       constraints: BoxConstraints(),
//                       padding: EdgeInsets.zero,
//                       onPressed: () =>
//                           context.read<AudioBloc>().add(StopAudio()),
//                       icon: Icon(
//                         Iconsax.close_circle_copy,
//                         color: AppColors.primary,
//                         size: 24,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (image.isNotEmpty)
//                 Positioned(
//                   right: 16,
//                   bottom: 20,
//                   child: Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.neutralMidnight.withValues(
//                             alpha: 0.3,
//                           ),
//                           blurRadius: 10,
//                           spreadRadius: 1,
//                           offset: const Offset(0, 0),
//                         ),
//                       ],
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: CachedNetworkImage(
//                         imageUrl: image,
//                         fadeInDuration: Duration(milliseconds: 300),
//                         placeholder: (context, url) =>
//                             LoadingAnimationWidget.flickr(
//                               leftDotColor: AppColors.primary,
//                               rightDotColor: AppColors.secondary,
//                               size: 20,
//                             ),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
