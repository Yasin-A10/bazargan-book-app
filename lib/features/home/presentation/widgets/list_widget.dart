import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ListWidget extends StatelessWidget {
  final String title;
  final String seeAll;
  final String? link;
  final double listHeight;
  // final List<String> items;
  const ListWidget({
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
                onTap: () {
                  context.push('/book-list');
                },
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
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    Images.listImg,
                    fit: BoxFit.cover,
                    width: 120,
                    height: 180,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 16);
            },
          ),
        ),
      ],
    );
  }
}
