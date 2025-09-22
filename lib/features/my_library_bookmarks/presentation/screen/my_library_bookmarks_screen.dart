import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/widgets/card/book_card_row.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MyLibraryBookmarksScreen extends StatelessWidget {
  const MyLibraryBookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نشان شده ها'),
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
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return BookCardRow(
            title: 'چگونه یک درونگرای تاثیر گذار باشیم',
            author: 'حسین کاظمی یزدی',
            publisher: 'انتشارات جیحون',
            price: '10000',
            rate: '4.5',
            image: 'assets/images/list-img.jpg',
            isSave: true,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }
}
