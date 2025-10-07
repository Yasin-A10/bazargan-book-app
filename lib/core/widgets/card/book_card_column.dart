import 'package:bazargan/config/router/route_paths.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/utils/number_formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BookCardColumn extends StatelessWidget {
  final int bookId;
  final String title;
  final String author;
  final String publisher;
  final int price;
  final String image;
  final String? discount;
  final double? rate;
  final bool? isSave;

  const BookCardColumn({
    super.key,
    required this.bookId,
    required this.image,
    required this.title,
    required this.author,
    required this.publisher,
    required this.price,
    this.discount,
    this.rate,
    this.isSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8,
      children: [
        GestureDetector(
          onTap: () => context.push(RoutePaths.book, extra: bookId),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.22),
                  blurRadius: 10,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                width: 130,
                height: 200,
                fit: BoxFit.cover,
                imageUrl: image,
                fadeInDuration: const Duration(milliseconds: 300),
                placeholder: (context, url) => Center(
                  child: LoadingAnimationWidget.flickr(
                    leftDotColor: AppColors.primary,
                    rightDotColor: AppColors.tertiary,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 4,
          children: [
            Text(
              title,
              style: AppTextStyles.headlineLarge.copyWith(fontSize: 12),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              author,
              style: AppTextStyles.small,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              publisher,
              style: AppTextStyles.small,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.star_1, color: AppColors.primary, size: 16),
                const SizedBox(width: 4),
                Text(
                  formatNumberToPersianWithoutSeparator(rate ?? '0'),
                  style: AppTextStyles.small,
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
