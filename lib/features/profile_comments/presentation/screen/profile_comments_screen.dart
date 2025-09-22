import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/features/profile_comments/presentation/widgets/user_comment_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProfileCommentsScreen extends StatelessWidget {
  const ProfileCommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نظرات من'),
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_right_1_copy,
            color: AppColors.neutral757575,
            size: 16,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView.separated(
        itemCount: 9,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemBuilder: (context, index) {
          return UserCommentCard(
            title: 'چگونه یک درونگرای تاثیر گذار باشیم',
            rating: 4,
            date: '۱۴۰۹/۰۹/۰۸',
            comment:
                'سوالات است کتابهای شناخت بلکه حروفچینی کرد و متون تمام ستون و کاربردهای چاپگرها نامفهوم، که شصت و سه درصد داشت است حال ابزارهای کاربردی طراحان',
            image: Images.listImg,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }
}
