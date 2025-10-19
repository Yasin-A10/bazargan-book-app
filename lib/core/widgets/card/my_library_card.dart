import 'package:bazargan/config/router/route_paths.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/widgets/button/button.dart';
import 'package:bazargan/core/widgets/inputs/star_rating.dart';
import 'package:bazargan/core/widgets/inputs/text_form_field.dart';
import 'package:bazargan/core/widgets/list_item_widget.dart';
import 'package:bazargan/features/my_library/data/models/my_library_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyLibraryCard extends StatelessWidget {
  final MyBook book;

  const MyLibraryCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            book.type == 'صوتی'
                ? context.push(RoutePaths.audioBook, extra: book.childBookId)
                : context.push(RoutePaths.book, extra: book.id);
          },
          child: Container(
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
                height: 205,
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
                          context.push(RoutePaths.book, extra: book.id);
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
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return Container(
  //         padding: const EdgeInsets.only(
  //           top: 8,
  //           bottom: 16,
  //           left: 16,
  //           right: 16,
  //         ),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(20),
  //             topRight: Radius.circular(20),
  //           ),
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Divider(
  //               color: AppColors.neutral757575,
  //               thickness: 3,
  //               endIndent: 140,
  //               indent: 140,
  //             ),
  //             const SizedBox(height: 16),
  //             Expanded(
  //               child: ListView.builder(
  //                 itemCount: indexes.length,
  //                 itemBuilder: (context, index) {
  //                   return Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       const SizedBox(height: 8),
  //                       Text(
  //                         indexes[index].title!,
  //                         style: AppTextStyles.body.copyWith(
  //                           fontSize: 14,
  //                           fontWeight: FontWeight.w300,
  //                         ),
  //                         textAlign: TextAlign.right,
  //                         overflow: TextOverflow.ellipsis,
  //                       ),
  //                       const SizedBox(height: 8),
  //                       Divider(color: AppColors.neutralE3E3E3, thickness: 1),
  //                     ],
  //                   );
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

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
