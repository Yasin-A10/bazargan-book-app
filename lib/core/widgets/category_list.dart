import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CategoryList extends StatelessWidget {
  final String title;
  final String seeAll;
  final String? link;
  final double listHeight;
  // final List<String> items;
  const CategoryList({
    super.key,
    required this.title,
    this.seeAll = 'همه',
    this.link,
    required this.listHeight,
    // required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title, style: AppTextStyles.headlineLarge),
              InkWell(
                onTap: () {},
                child: Row(
                  spacing: 4,
                  children: [
                    Text(seeAll, style: AppTextStyles.body),
                    Icon(
                      Iconsax.arrow_left_2_copy,
                      color: AppColors.neutral757575,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: listHeight,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            children: [
              Row(
                children: [
                  CategoryItem(
                    backgroundColor: AppColors.primaryTint8,
                    contentColor: AppColors.primary,
                    label: 'مجموعه کاربرد در تجارت (زینال‌زاده)',
                    icon: SvgPicture.asset(
                      Images.category1,
                      height: 30,
                      width: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  CategoryItem(
                    backgroundColor: AppColors.secondaryTint8,
                    contentColor: AppColors.secondary,
                    label: 'مجموعه کاربرد در تجارت (زینال‌زاده)',
                    icon: Icon(
                      Iconsax.book_copy,
                      color: AppColors.secondary,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 16),
                  CategoryItem(
                    backgroundColor: AppColors.tertiaryTint8,
                    contentColor: AppColors.tertiary,
                    label: 'مجموعه کاربرد در تجارت (زینال‌زاده)',
                    icon: Icon(
                      Iconsax.activity_copy,
                      color: AppColors.tertiary,
                      size: 80,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Color backgroundColor;
  final Color contentColor;
  final String label;
  final Widget icon;

  const CategoryItem({
    super.key,
    required this.backgroundColor,
    required this.contentColor,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 56,
            width: 56,
            child: FittedBox(fit: BoxFit.contain, child: icon),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: contentColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
