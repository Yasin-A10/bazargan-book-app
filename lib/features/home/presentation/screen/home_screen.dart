import 'package:bazargan/config/router/route_paths.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/widgets/button/button.dart';
import 'package:bazargan/core/widgets/category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/features/home/presentation/widgets/list_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () => context.push(RoutePaths.book),
          child: SvgPicture.asset(Images.bazarganRed, height: 40),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Button(
                label: 'دسته‌بندی‌ها',
                textColor: AppColors.secondary,
                backgroundColor: AppColors.secondaryTint8,
                width: double.infinity,
                onPressed: () {},
                icon: Icon(
                  Iconsax.element_3,
                  size: 20,
                  color: AppColors.secondary,
                ),
              ),
            ),
            ListWidget(title: 'جدیدترین‌ها', listHeight: 180),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: AppColors.neutralE3E3E3),
            ),
            CategoryList(title: 'دسته‌بندی', listHeight: 140),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: AppColors.neutralE3E3E3),
            ),
            ListWidget(title: 'محبوب‌ترین‌‌ها', listHeight: 180),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: AppColors.neutralE3E3E3),
            ),
            ListWidget(title: 'جدیدترین‌ها', listHeight: 180),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: AppColors.neutralE3E3E3),
            ),
            ListWidget(title: 'پرفروشترین‌ها', listHeight: 180),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: AppColors.neutralE3E3E3),
            ),
            ListWidget(title: 'پرفروش‌ترین‌های متنی', listHeight: 180),
          ],
        ),
      ),
    );
  }
}
