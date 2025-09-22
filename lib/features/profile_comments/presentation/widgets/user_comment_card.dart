import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/widgets/button/button.dart';
import 'package:bazargan/core/widgets/inputs/star_rating.dart';
import 'package:bazargan/core/widgets/inputs/text_form_field.dart';
import 'package:bazargan/core/widgets/show_star_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class UserCommentCard extends StatelessWidget {
  final String title;
  final int rating;
  final String date;
  final String comment;
  final String image;
  const UserCommentCard({
    super.key,
    required this.title,
    required this.rating,
    required this.date,
    required this.comment,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 10,
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.30),
                      blurRadius: 10.8,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    image,
                    width: 44,
                    height: 65,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.neutralMidnight,
                    ),
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      ShowStarRating(rating: rating),
                      Text(
                        date,
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
                  InkWell(
                    onTap: () {
                      _openEdit(context);
                    },
                    child: SvgPicture.asset(Images.edit, width: 20, height: 20),
                  ),
                  InkWell(
                    onTap: () {
                      _openDelete(context);
                    },
                    child: SvgPicture.asset(
                      Images.trash,
                      width: 20,
                      height: 20,
                    ),
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

  void _openEdit(BuildContext context) {
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
                      'چگونه یک درون گرای تاثیر گذار باشیم',
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

  void _openDelete(BuildContext context) {
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
                'حذف نظر',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
              Text(
                'آیا نسبت به حذف نظر خود اطمینان دارید؟',
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
