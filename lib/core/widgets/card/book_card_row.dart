import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/utils/number_formater.dart';
import 'package:bazargan/features/my_library_bookmarks/presentation/bloc/marked_books_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BookCardRow extends StatelessWidget {
  final int bookId;
  final String title;
  final String author;
  final String publisher;
  final int price;
  final String image;
  final String? discount;
  final double? rate;
  final bool? isSave;

  const BookCardRow({
    super.key,
    required this.bookId,
    required this.title,
    required this.author,
    required this.publisher,
    required this.price,
    required this.image,
    this.discount,
    this.rate,
    this.isSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
              width: 75,
              height: 110,
              fit: BoxFit.cover,
              imageUrl: image,
              fadeInDuration: const Duration(milliseconds: 300),
              placeholder: (context, url) => Center(
                child: LoadingAnimationWidget.flickr(
                  leftDotColor: AppColors.primary,
                  rightDotColor: AppColors.tertiary,
                  size: 20,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 4,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.headlineLarge.copyWith(fontSize: 12),
                    ),
                  ),

                  BlocBuilder<MarkedBooksBloc, MarkedBooksState>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: state is AddBookmarkLoading
                            ? null
                            : () {
                                context.read<MarkedBooksBloc>().add(
                                  AddBookmarkEvent(bookId: bookId),
                                );
                              },
                        icon: state is AddBookmarkLoading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                  color: AppColors.secondary,
                                ),
                              )
                            : Icon(
                                isSave == true
                                    ? Iconsax.save_2
                                    : Iconsax.save_2_copy,
                                color: AppColors.secondary,
                                size: 16,
                              ),
                      );
                    },
                  ),
                ],
              ),

              Text(author, style: AppTextStyles.small),
              Text(publisher, style: AppTextStyles.small),

              Row(
                children: [
                  Icon(Iconsax.star_1, color: AppColors.primary, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    formatNumberToPersianWithoutSeparator(rate ?? '0'),
                    style: AppTextStyles.small,
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    formatNumberToPersian(price),
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(Images.tooman, width: 16, height: 16),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
