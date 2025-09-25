import 'package:bazargan/config/router/route_paths.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/utils/number_formater.dart';
import 'package:bazargan/core/widgets/button/button.dart';
import 'package:bazargan/core/widgets/category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/widgets/list_widget.dart';
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
      body: Stack(
        children: [
          SingleChildScrollView(
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
                    onPressed: () {
                      context.push(RoutePaths.login);
                    },
                    icon: Icon(
                      Iconsax.element_3,
                      size: 20,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
                SizedBox(height: 0),

                ListWidget(title: 'جدیدترین‌ها', listHeight: 200),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(color: AppColors.neutralE3E3E3),
                ),

                CategoryList(title: 'دسته‌بندی', listHeight: 80),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(color: AppColors.neutralE3E3E3),
                ),

                ListWidget(title: 'محبوب‌ترین‌‌ها', listHeight: 200),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(color: AppColors.neutralE3E3E3),
                ),

                ListWidget(title: 'جدیدترین‌ها', listHeight: 200),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(color: AppColors.neutralE3E3E3),
                ),
                ListWidget(title: 'پرفروشترین‌ها', listHeight: 200),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(color: AppColors.neutralE3E3E3),
                ),

                ListWidget(title: 'پرفروش‌ترین‌های متنی', listHeight: 200),
              ],
            ),
          ),
          CartButton(count: 3),
        ],
      ),
    );
  }
}

class CartButton extends StatelessWidget {
  final int count;
  const CartButton({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Stack(
          children: [
            IconButton(
              onPressed: () {
                GoRouter.of(context).push(RoutePaths.cart);
              },
              icon: Icon(
                Iconsax.bag_2_copy,
                size: 22,
                color: AppColors.primary,
              ),
            ),
            Positioned(
              bottom: 4,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  formatNumberToPersian(count),
                  style: AppTextStyles.small.copyWith(
                    color: AppColors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
