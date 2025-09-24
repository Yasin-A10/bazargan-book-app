import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/widgets/card/book_card_column.dart';
import 'package:bazargan/core/widgets/card/book_card_row.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  bool isColumn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'لیست کتاب‌ها',
          style: AppTextStyles.headlineLarge.copyWith(fontSize: 14),
        ),
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_right_1_copy,
            color: AppColors.neutral757575,
            size: 16,
          ),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: isColumn
                ? const Icon(
                    Iconsax.element_3_copy,
                    size: 16,
                    color: AppColors.neutral757575,
                  )
                : const Icon(
                    Iconsax.row_vertical_copy,
                    size: 16,
                    color: AppColors.neutral757575,
                  ),
            onPressed: () => setState(() => isColumn = !isColumn),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        switchInCurve: Curves.easeInOutCubic,
        switchOutCurve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: animation, child: child),
          );
        },
        child: isColumn
            ? ListView.separated(
                itemCount: 9,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return const BookCardRow(
                    title: 'چگونه یک درونگرای تاثیر گذار باشیم',
                    author: 'حسین کاظمی یزدی',
                    publisher: 'انتشارات جیحون',
                    price: '10000',
                    rate: '4.5',
                    image: 'assets/images/list-img.jpg',
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
              )
            : GridView.builder(
                itemCount: 9,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.55,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return BookCardColumn(
                    title: 'چگونه یک درونگرای تاثیر گذار باشیم',
                    author: 'حسین کاظمی یزدی',
                    publisher: 'انتشارات جیحون',
                    price: '10000',
                    rate: '4.5',
                    image: 'assets/images/list-img.jpg',
                  );
                },
              ),
      ),
    );
  }
}
