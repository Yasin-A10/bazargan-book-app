import 'package:bazargan/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "icon": Iconsax.home_2_copy,
        "activeIcon": Iconsax.home_1,
        "label": "خانه",
      },
      // {
      //   "icon": Iconsax.polygon_matic_copy,
      //   "activeIcon": Iconsax.polygon_matic,
      //   "label": "اشتراک ویژه",
      // },
      {
        "icon": Iconsax.chart_1_copy,
        "activeIcon": Iconsax.chart_1,
        "label": "کتابخانه من",
      },
      {
        "icon": Iconsax.search_normal_1_copy,
        "activeIcon": Iconsax.search_normal_1,
        "label": "جستجو",
      },
      {
        "icon": Iconsax.user_copy,
        "activeIcon": Iconsax.user,
        "label": "پروفایل",
      },
    ];

    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 16, left: 12, right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = widget.currentIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => widget.onTap(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSelected
                        ? items[index]["activeIcon"] as IconData
                        : items[index]["icon"] as IconData,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    items[index]["label"] as String,
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.primary,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: 3,
                    width: isSelected ? 24 : 0,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
