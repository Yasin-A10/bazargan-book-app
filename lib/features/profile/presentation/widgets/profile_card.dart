import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData mainIcon;
  final IconData subIcon;
  final Color background;
  final Function()? onTap;
  const ProfileCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.mainIcon,
    required this.subIcon,
    required this.background,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(mainIcon, color: AppColors.white, size: 32),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                title,
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.white,
                ),
              ),
              Text(
                subtitle,
                style: AppTextStyles.body.copyWith(color: AppColors.white),
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: IconButton(
                icon: Icon(subIcon, color: background, size: 20),
                onPressed: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
