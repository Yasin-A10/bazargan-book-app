import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/widgets/button/button.dart';
import 'package:bazargan/features/profile_favorites/presentation/widgets/category_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

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

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final Set<int> selectedIndexes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(color: AppColors.primary),
          ),

          //! Logo
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  SvgPicture.asset(Images.bazarganWhite, height: 60, width: 60),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    spacing: 32,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'جهت ارائه خدمات مفید تر دسته بندی‌های مورد علاقه خود را انتخاب کنید',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: AppColors.neutral757575,
                        ),
                      ),

                      // بخش اسکرول شونده
                      Expanded(
                        child: ListView.separated(
                          itemCount: categories.length,
                          padding: const EdgeInsets.symmetric(vertical: 16),
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
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                        ),
                      ),

                      // دکمه ثابت
                      Button(
                        label: 'تایید',
                        width: double.infinity,
                        backgroundColor: AppColors.secondary,
                        onPressed: () {
                          context.go('/');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
