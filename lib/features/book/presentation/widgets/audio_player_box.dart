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

// // import 'package:bazargan/core/blocs/audio/audio_bloc.dart';
// // import 'package:bazargan/core/constants/colors.dart';
// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:iconsax_flutter/iconsax_flutter.dart';
// // import 'package:loading_animation_widget/loading_animation_widget.dart';

// // class AudioPlayerBox extends StatelessWidget {
// //   const AudioPlayerBox({super.key});

// //   /// تبدیل Duration به فرمت mm:ss
// //   String _formatDuration(Duration duration) {
// //     String twoDigits(int n) => n.toString().padLeft(2, '0');
// //     final minutes = twoDigits(duration.inMinutes.remainder(60));
// //     final seconds = twoDigits(duration.inSeconds.remainder(60));
// //     return '$minutes:$seconds';
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<AudioBloc, AudioState>(
// //       builder: (context, state) {
// //         // عدم نمایش در حالت اولیه یا توقف کامل
// //         if (state is AudioInitial || state is AudioStopped) {
// //           return const SizedBox.shrink();
// //         }

// //         // نمایش Loading
// //         if (state is AudioLoading) {
// //           return _buildLoadingBox(state);
// //         }

// //         // نمایش خطا
// //         if (state is AudioError) {
// //           return _buildErrorBox(state);
// //         }

// //         // استخراج اطلاعات از state
// //         final title = state.title ?? '';
// //         final image = state.image ?? '';
// //         final position = state.position ?? Duration.zero;
// //         final duration = state.duration ?? Duration.zero;
// //         final isPlaying = state is AudioPlaying;

// //         return Align(
// //           alignment: Alignment.bottomCenter,
// //           child: Stack(
// //             clipBehavior: Clip.none,
// //             children: [
// //               Container(
// //                 padding: const EdgeInsets.only(
// //                   right: 76,
// //                   left: 12,
// //                   bottom: 8,
// //                   top: 12,
// //                 ),
// //                 decoration: BoxDecoration(
// //                   color: AppColors.white,
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: AppColors.neutralMidnight.withValues(alpha: 0.1),
// //                       blurRadius: 10,
// //                       spreadRadius: 2,
// //                       offset: const Offset(0, 0),
// //                     ),
// //                   ],
// //                   borderRadius: const BorderRadius.only(
// //                     topLeft: Radius.circular(16),
// //                     topRight: Radius.circular(16),
// //                   ),
// //                 ),
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     // ردیف اول: عنوان و دکمه بستن
// //                     Row(
// //                       children: [
// //                         const SizedBox(width: 8),
// //                         Expanded(
// //                           child: Text(
// //                             title,
// //                             style: TextStyle(
// //                               color: AppColors.neutralMidnight,
// //                               fontSize: 14,
// //                               fontWeight: FontWeight.w600,
// //                             ),
// //                             maxLines: 1,
// //                             textAlign: TextAlign.right,
// //                             overflow: TextOverflow.ellipsis,
// //                           ),
// //                         ),
// //                         IconButton(
// //                           constraints: const BoxConstraints(),
// //                           padding: EdgeInsets.zero,
// //                           onPressed: () =>
// //                               context.read<AudioBloc>().add(StopAudio()),
// //                           icon: Icon(
// //                             Iconsax.close_circle_copy,
// //                             color: AppColors.primary,
// //                             size: 22,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 8),

// //                     // Progress Bar با Slider
// //                     Row(
// //                       children: [
// //                         Text(
// //                           _formatDuration(position),
// //                           style: TextStyle(
// //                             fontSize: 11,
// //                             color: AppColors.neutralMidnight.withOpacity(0.7),
// //                           ),
// //                         ),
// //                         Expanded(
// //                           child: SliderTheme(
// //                             data: SliderThemeData(
// //                               trackHeight: 3,
// //                               thumbShape: const RoundSliderThumbShape(
// //                                 enabledThumbRadius: 6,
// //                               ),
// //                               overlayShape: const RoundSliderOverlayShape(
// //                                 overlayRadius: 12,
// //                               ),
// //                               activeTrackColor: AppColors.primary,
// //                               inactiveTrackColor:
// //                                   AppColors.neutralMidnight.withOpacity(0.2),
// //                               thumbColor: AppColors.primary,
// //                               overlayColor: AppColors.primary.withOpacity(0.2),
// //                             ),
// //                             child: Slider(
// //                               value: duration.inSeconds > 0
// //                                   ? position.inSeconds
// //                                       .clamp(0, duration.inSeconds)
// //                                       .toDouble()
// //                                   : 0.0,
// //                               min: 0.0,
// //                               max: duration.inSeconds > 0
// //                                   ? duration.inSeconds.toDouble()
// //                                   : 1.0,
// //                               onChanged: (value) {
// //                                 context.read<AudioBloc>().add(
// //                                       SeekAudio(
// //                                         Duration(seconds: value.toInt()),
// //                                       ),
// //                                     );
// //                               },
// //                             ),
// //                           ),
// //                         ),
// //                         Text(
// //                           _formatDuration(duration),
// //                           style: TextStyle(
// //                             fontSize: 11,
// //                             color: AppColors.neutralMidnight.withOpacity(0.7),
// //                           ),
// //                         ),
// //                       ],
// //                     ),

// //                     // دکمه‌های کنترل
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         // دکمه عقب ۵ ثانیه
// //                         IconButton(
// //                           onPressed: () =>
// //                               context.read<AudioBloc>().add(SeekBackward()),
// //                           icon: Icon(
// //                             Iconsax.backward_5_seconds,
// //                             color: AppColors.primary,
// //                             size: 28,
// //                           ),
// //                         ),
// //                         const SizedBox(width: 16),

// //                         // دکمه Play/Pause
// //                         IconButton(
// //                           onPressed: () =>
// //                               context.read<AudioBloc>().add(TogglePlayPause()),
// //                           icon: Icon(
// //                             isPlaying ? Iconsax.pause : Iconsax.play,
// //                             color: AppColors.primary,
// //                             size: 36,
// //                           ),
// //                         ),
// //                         const SizedBox(width: 16),

// //                         // دکمه جلو ۵ ثانیه
// //                         IconButton(
// //                           onPressed: () =>
// //                               context.read<AudioBloc>().add(SeekForward()),
// //                           icon: Icon(
// //                             Iconsax.forward_5_seconds,
// //                             color: AppColors.primary,
// //                             size: 28,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               // تصویر کاور
// //               if (image.isNotEmpty)
// //                 Positioned(
// //                   right: 16,
// //                   bottom: 24,
// //                   child: Container(
// //                     width: 60,
// //                     height: 60,
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(8),
// //                       boxShadow: [
// //                         BoxShadow(
// //                           color: AppColors.neutralMidnight.withValues(
// //                             alpha: 0.3,
// //                           ),
// //                           blurRadius: 10,
// //                           spreadRadius: 1,
// //                           offset: const Offset(0, 0),
// //                         ),
// //                       ],
// //                     ),
// //                     child: ClipRRect(
// //                       borderRadius: BorderRadius.circular(8),
// //                       child: CachedNetworkImage(
// //                         imageUrl: image,
// //                         fadeInDuration: const Duration(milliseconds: 300),
// //                         placeholder: (context, url) =>
// //                             LoadingAnimationWidget.flickr(
// //                           leftDotColor: AppColors.primary,
// //                           rightDotColor: AppColors.secondary,
// //                           size: 20,
// //                         ),
// //                         fit: BoxFit.cover,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   /// ویجت برای حالت بارگذاری
// //   Widget _buildLoadingBox(AudioLoading state) {
// //     return Align(
// //       alignment: Alignment.bottomCenter,
// //       child: Container(
// //         height: 60,
// //         padding: const EdgeInsets.symmetric(horizontal: 16),
// //         decoration: BoxDecoration(
// //           color: AppColors.white,
// //           boxShadow: [
// //             BoxShadow(
// //               color: AppColors.neutralMidnight.withValues(alpha: 0.1),
// //               blurRadius: 10,
// //               spreadRadius: 2,
// //               offset: const Offset(0, 0),
// //             ),
// //           ],
// //           borderRadius: const BorderRadius.only(
// //             topLeft: Radius.circular(16),
// //             topRight: Radius.circular(16),
// //           ),
// //         ),
// //         child: Row(
// //           children: [
// //             LoadingAnimationWidget.flickr(
// //               leftDotColor: AppColors.primary,
// //               rightDotColor: AppColors.secondary,
// //               size: 24,
// //             ),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Text(
// //                 'در حال بارگذاری ${state.title}...',
// //                 style: TextStyle(
// //                   color: AppColors.neutralMidnight,
// //                   fontSize: 14,
// //                 ),
// //                 maxLines: 1,
// //                 overflow: TextOverflow.ellipsis,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   /// ویجت برای حالت خطا
// //   Widget _buildErrorBox(AudioError state) {
// //     return Align(
// //       alignment: Alignment.bottomCenter,
// //       child: Container(
// //         height: 60,
// //         padding: const EdgeInsets.symmetric(horizontal: 16),
// //         decoration: BoxDecoration(
// //           color: Colors.red.shade50,
// //           borderRadius: const BorderRadius.only(
// //             topLeft: Radius.circular(16),
// //             topRight: Radius.circular(16),
// //           ),
// //         ),
// //         child: Row(
// //           children: [
// //             Icon(Iconsax.danger, color: Colors.red.shade700, size: 24),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Text(
// //                 state.message,
// //                 style: TextStyle(
// //                   color: Colors.red.shade700,
// //                   fontSize: 13,
// //                 ),
// //                 maxLines: 2,
// //                 overflow: TextOverflow.ellipsis,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
