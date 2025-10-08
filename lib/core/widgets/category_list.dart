import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/features/home/data/model/home_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CategoryList extends StatelessWidget {
  final String title;
  final String seeAll;
  final String? link;
  final double listHeight;
  final List<CategoryModel> categories;

  const CategoryList({
    super.key,
    required this.title,
    this.seeAll = 'همه',
    this.link,
    required this.listHeight,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      {"bg": AppColors.primaryTint8, "content": AppColors.primary},
      {"bg": AppColors.tertiaryTint8, "content": AppColors.tertiary},
      {"bg": AppColors.secondaryTint8, "content": AppColors.secondary},
    ];

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
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final colorSet = colors[index % colors.length];
              final category = categories[index];

              return CategoryItem(
                backgroundColor: colorSet["bg"]!,
                contentColor: colorSet["content"]!,
                label: category.title,
                icon: SvgPicture.network(
                  category.icon,
                  colorFilter: ColorFilter.mode(
                    colorSet["content"]!,
                    BlendMode.srcIn,
                  ),
                  height: 30,
                  width: 30,
                ),
                onTap: () {
                  context.pushNamed(
                    'books',
                    queryParameters: {
                      'title': category.title,
                      'type': 'category',
                      'value': category.id.toString(),
                    },
                  );
                },
              );
            },
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
  final Function() onTap;

  const CategoryItem({
    super.key,
    required this.backgroundColor,
    required this.contentColor,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              width: 30,
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
      ),
    );
  }
}
