import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/features/profile_favorites/presentation/widgets/category_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

final List<Map<String, String>> categories = [
  {
    'title': 'رمان',
    'icon': Images.category1,
    'isSelectedIcon': Images.category1White,
  },
  {
    'title': 'تاریخ',
    'icon': Images.category1,
    'isSelectedIcon': Images.category1White,
  },
  {
    'title': 'علم',
    'icon': Images.category1,
    'isSelectedIcon': Images.category1White,
  },
  {
    'title': 'فیلسوفی',
    'icon': Images.category1,
    'isSelectedIcon': Images.category1White,
  },
  {
    'title': 'مدیریت',
    'icon': Images.category1,
    'isSelectedIcon': Images.category1White,
  },
  {
    'title': 'سفر در زمان',
    'icon': Images.category1,
    'isSelectedIcon': Images.category1White,
  },
  {
    'title': 'دینی',
    'icon': Images.category1,
    'isSelectedIcon': Images.category1White,
  },
  {
    'title': 'کسب و کار',
    'icon': Images.category1,
    'isSelectedIcon': Images.category1White,
  },
  {
    'title': 'سیاسی',
    'icon': Images.category1,
    'isSelectedIcon': Images.category1White,
  },
  {
    'title': 'علوم اجتماعی',
    'icon': Images.category1,
    'isSelectedIcon': Images.category1White,
  },
  {
    'title': 'علوم پزشکی',
    'icon': Images.category1,
    'isSelectedIcon': Images.category1White,
  },
  {
    'title': 'علوم زیستی',
    'icon': Images.category1,
    'isSelectedIcon': Images.category1White,
  },
  {
    'title': 'نجوم',
    'icon': Images.category1,
    'isSelectedIcon': Images.category1White,
  },
  {
    'title': 'نقد و ارزیابی',
    'icon': Images.category1,
    'isSelectedIcon': Images.category1White,
  },
  {
    'title': 'فیزیک',
    'icon': Images.category1,
    'isSelectedIcon': Images.category1White,
  },
  {
    'title': 'ریاضیات',
    'icon': Images.category1,
    'isSelectedIcon': Images.category1White,
  },
];

class ProfileFavoritesScreen extends StatefulWidget {
  const ProfileFavoritesScreen({super.key});

  @override
  State<ProfileFavoritesScreen> createState() => _ProfileFavoritesScreenState();
}

class _ProfileFavoritesScreenState extends State<ProfileFavoritesScreen> {
  final Set<int> selectedIndexes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('دسته بندی های مورد علاقه'),
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_right_1_copy,
            color: AppColors.neutral757575,
            size: 16,
          ),
          onPressed: () => context.pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: SvgPicture.asset(Images.tickButton, height: 32),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              'جهت ارائه خدمات مفیدتر دسته بندی‌های مورد علاقه خود را انتخاب کنید',
              style: AppTextStyles.body.copyWith(
                color: AppColors.neutral757575,
                fontWeight: FontWeight.w300,
                height: 1.8,
              ),
            ),
            const SizedBox(height: 24),
            ListView.separated(
              itemCount: categories.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryItemWidget(
                  title: category['title']!,
                  icon: category['icon']!,
                  isSelectedIcon: category['isSelectedIcon']!,
                  isSelected: selectedIndexes.contains(index),
                  onTap: () {
                    setState(() {
                      if (selectedIndexes.contains(index)) {
                        selectedIndexes.remove(index);
                      } else {
                        selectedIndexes.add(index);
                      }
                    });
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            ),
          ],
        ),
      ),
    );
  }
}
