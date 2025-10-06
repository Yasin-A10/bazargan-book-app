import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/utils/convert_to_jalali.dart';
import 'package:bazargan/core/utils/number_formater.dart';
import 'package:bazargan/core/widgets/show_star_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookCommentCard extends StatelessWidget {
  final String? title;
  final double? rating;
  final String date;
  final String comment;
  final bool isLiked;
  final bool isDisLiked;
  final int likeCount;
  final int dislikeCount;
  const BookCommentCard({
    super.key,
    required this.title,
    this.rating,
    required this.date,
    required this.comment,
    required this.isLiked,
    required this.likeCount,
    required this.dislikeCount,
    required this.isDisLiked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        spacing: 12,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? 'بدون نام',
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.neutralMidnight,
                    ),
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      ShowStarRating(rating: rating?.toInt() ?? 0),
                      Text(
                        formatNumberToPersianWithoutSeparator(
                          convertToJalaliDate(date),
                        ),
                        style: AppTextStyles.small.copyWith(
                          color: AppColors.neutral757575,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                spacing: 16,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 4,
                    children: [
                      Text(
                        formatNumberToPersian(likeCount),
                        style: AppTextStyles.small,
                      ),
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                          isLiked ? Images.likeBold : Images.like,
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 4,
                    children: [
                      Text(
                        formatNumberToPersian(dislikeCount),
                        style: AppTextStyles.small,
                      ),
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                          isDisLiked ? Images.dislikeBold : Images.dislike,
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Text(
            comment,
            textAlign: TextAlign.justify,
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w300,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}
