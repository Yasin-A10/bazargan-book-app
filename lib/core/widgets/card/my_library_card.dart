import 'dart:io';
import 'dart:typed_data';

import 'package:bazargan/config/router/route_paths.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/utils/dycrypt.dart';
import 'package:bazargan/core/widgets/button/button.dart';
import 'package:bazargan/core/widgets/inputs/star_rating.dart';
import 'package:bazargan/core/widgets/inputs/text_form_field.dart';
import 'package:bazargan/core/widgets/list_item_widget.dart';
import 'package:bazargan/features/book/presentation/bloc/book_file/book_file_bloc.dart';
import 'package:bazargan/features/my_library/data/models/my_library_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';

class MyLibraryCard extends StatelessWidget {
  final MyBook book;

  const MyLibraryCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocConsumer<BookFileBloc, BookFileState>(
          listener: (context, state) async {
            if (state is BookFileLoaded && state.bookId == book.id) {
              final path = book.type == 'epub'
                  ? await _decryptAndSaveFileEpub(state.file)
                  : await _decryptAndSaveFile(state.file);

              if (!context.mounted) return;

              context.push(
                book.type == 'epub'
                    ? RoutePaths.epubDecryptViewer
                    : RoutePaths.pdfDecryptViewer,
                extra: path,
              );
            }
            if (state is BookFileError) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('خطا در بارگذاری کتاب')),
              );
            }
          },
          // listener: (context, state) async {
          //   if (state is BookFileLoaded) {
          //     String path;
          //     if (widget.book.type == 'epub') {
          //       path = await _decryptAndSaveFileEpub(state.file);
          //     } else {
          //       path = await _decryptAndSaveFile(state.file);
          //     }

          //     if (!context.mounted) return;

          //     if (widget.book.type == 'epub') {
          //       if (!context.mounted) return;

          //       context.push(RoutePaths.epubDecryptViewer, extra: path);
          //     } else {
          //       if (!context.mounted) return;

          //       context.push(RoutePaths.pdfDecryptViewer, extra: path);
          //     }
          //   }

          //   if (state is BookFileError) {
          //     ScaffoldMessenger.of(context)
          //       ..clearSnackBars()
          //       ..showSnackBar(
          //         SnackBar(
          //           backgroundColor: AppColors.primary,
          //           content: const Text('خطا در بارگذاری کتاب'),
          //         ),
          //       );
          //   }
          // },
          builder: (context, state) {
            return GestureDetector(
              onTap: () async {
                if (book.type == 'صوتی') {
                  context.push(RoutePaths.audioBook, extra: book.childBookId);
                  return;
                }

                if (book.type case 'pdf' || 'epub') {
                  final existing = await _getExistingDecryptedFile();
                  if (existing != null && context.mounted) {
                    context.push(
                      book.type == 'epub'
                          ? RoutePaths.epubDecryptViewer
                          : RoutePaths.pdfDecryptViewer,
                      extra: existing,
                    );
                    return;
                  }

                  context.read<BookFileBloc>().add(
                    LoadBookFileEvent(bookId: book.id!),
                  );
                  return;
                }

                context.push('/book/${book.id}');
              },
              // onTap: () {
              //   if (widget.book.type == 'صوتی') {
              //     context.push(
              //       RoutePaths.audioBook,
              //       extra: widget.book.childBookId,
              //     );
              //   } else if (widget.book.type == 'pdf' ||
              //       widget.book.type == 'epub') {
              //     context.read<BookFileBloc>().add(
              //       LoadBookFileEvent(bookId: widget.book.id!),
              //     );
              //   } else {
              //     context.push('/book/${widget.book.id}');
              //   }
              // },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: book.picture!,
                        width: 136,
                        height: book.type == 'صوتی' ? 136 : 205,
                        fit: BoxFit.cover,
                        fadeInDuration: const Duration(milliseconds: 300),
                        placeholder: (context, url) => Center(
                          child: LoadingAnimationWidget.flickr(
                            leftDotColor: AppColors.primary,
                            rightDotColor: AppColors.secondary,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (state is BookFileLoading && state.bookId == book.id)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: LoadingAnimationWidget.hexagonDots(
                            color: AppColors.primary,
                            size: 45,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              onPressed: () {
                _openMenu(context, book);
              },
              icon: Icon(Iconsax.more_copy, size: 24, color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }

  Future<String?> _getExistingDecryptedFile() async {
    final dir = Directory(
      '${(await getApplicationDocumentsDirectory()).path}/books',
    );
    if (!await dir.exists()) await dir.create(recursive: true);
    final path = '${dir.path}/book_${book.id}_decrypted.${book.type}';
    return await File(path).exists() ? path : null;
  }

  Future<String> _decryptAndSaveFile(Uint8List fileBytes) async {
    final decrypted = await decryptFile(fileBytes, 'k*KXM09l%RhPF99d');
    final dir = Directory(
      '${(await getApplicationDocumentsDirectory()).path}/books',
    );
    if (!await dir.exists()) await dir.create(recursive: true);
    final path = '${dir.path}/book_${book.id}_decrypted.pdf';
    await File(path).writeAsBytes(decrypted, flush: true);
    return path;
  }

  Future<String> _decryptAndSaveFileEpub(Uint8List fileBytes) async {
    final decrypted = await decryptFile(fileBytes, 'k*KXM09l%RhPF99d');
    final dir = Directory(
      '${(await getApplicationDocumentsDirectory()).path}/books',
    );
    if (!await dir.exists()) await dir.create(recursive: true);
    final path = '${dir.path}/book_${book.id}_decrypted.epub';
    await File(path).writeAsBytes(decrypted, flush: true);
    return path;
  }

  // Future<String> _decryptAndSaveFile(Uint8List fileBytes) async {
  void _openMenu(BuildContext context, MyBook book) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    transform: GradientRotation(0.4),
                    colors: [
                      AppColors.primary.withValues(alpha: 0.4),
                      AppColors.neutralMidnight.withValues(alpha: 0.2),
                      AppColors.secondary.withValues(alpha: 0.4),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 16,
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(
                        color: AppColors.neutral757575,
                        thickness: 3,
                        endIndent: 140,
                        indent: 140,
                      ),
                      const SizedBox(height: 16),
                      Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                      const SizedBox(height: 8),
                      ListItemWidget(
                        title: 'صفحه معرفی کتاب',
                        titleStyle: AppTextStyles.body.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        rightIcon: Icon(
                          Iconsax.book_copy,
                          size: 20,
                          color: AppColors.neutralMidnight,
                        ),
                        leftIcon: Iconsax.arrow_left_2_copy,
                        onPressed: () {
                          context.push('/book/${book.id}');
                        },
                      ),
                      const SizedBox(height: 8),
                      Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                      const SizedBox(height: 8),
                      ListItemWidget(
                        title: 'فهرست کتاب',
                        titleStyle: AppTextStyles.body.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        rightIcon: Icon(
                          Iconsax.menu_1_copy,
                          size: 20,
                          color: AppColors.neutralMidnight,
                        ),
                        leftIcon: Iconsax.arrow_left_2_copy,
                        onPressed: () {
                          // _openCategoryMenu(context, book);
                        },
                      ),
                      const SizedBox(height: 8),
                      Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                      const SizedBox(height: 8),
                      ListItemWidget(
                        title: 'افزودن نظر',
                        titleStyle: AppTextStyles.body.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        rightIcon: Icon(
                          Iconsax.messages_3_copy,
                          size: 20,
                          color: AppColors.neutralMidnight,
                        ),
                        leftIcon: Iconsax.arrow_left_2_copy,
                        onPressed: () {
                          _openReviewMenu(context, book.name!);
                        },
                      ),
                      const SizedBox(height: 8),
                      Divider(color: AppColors.neutralE3E3E3, thickness: 1),

                      const SizedBox(height: 8),
                      ListItemWidget(
                        title: 'حذف از کتابخانه من',
                        titleStyle: AppTextStyles.body.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        rightIcon: Icon(
                          Iconsax.trash_copy,
                          size: 20,
                          color: AppColors.neutralMidnight,
                        ),
                        onPressed: () {
                          _openDeleteMenu(context);
                        },
                      ),

                      const SizedBox(height: 8),
                      Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //   void _openCategoryMenu(BuildContext context, List<Index> indexes) {
  void _openReviewMenu(BuildContext context, String bookName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  color: AppColors.neutral757575,
                  thickness: 3,
                  endIndent: 140,
                  indent: 140,
                ),
                Text(
                  'ثبت نظر',
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 0),
                Column(
                  spacing: 8,
                  children: [
                    Text(
                      bookName,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    StarRating(
                      maxRating: 5,
                      onRatingChanged: (rating) {
                        //? Handle rating change
                      },
                    ),
                  ],
                ),
                InputTextFormField(
                  label: 'متن نظر',
                  keyboardType: TextInputType.text,
                  maxLines: 6,
                  controller: TextEditingController(),
                ),
                Button(
                  label: 'افزودن نظر',
                  onPressed: () {
                    context.pop();
                  },
                  width: double.infinity,
                  backgroundColor: AppColors.secondary,
                  textColor: AppColors.white,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openDeleteMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 20,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            spacing: 16,
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(
                color: AppColors.neutral757575,
                thickness: 3,
                endIndent: 140,
                indent: 140,
              ),
              Text(
                'حذف کتاب از کتابخانه من',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
              Text(
                'امکان دوباره افزودن به کتابخانه من بصورت رایگان وجود دارد',
                style: AppTextStyles.small.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                ),
              ),
              Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: Button(
                      label: 'بازگشت',
                      onPressed: () {
                        context.pop();
                      },
                      width: double.infinity,
                      backgroundColor: AppColors.white,
                      textColor: AppColors.secondary,
                      borderColor: AppColors.secondary,
                    ),
                  ),
                  Expanded(
                    child: Button(
                      label: 'حذف',
                      onPressed: () {
                        context.pop();
                      },
                      width: double.infinity,
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
