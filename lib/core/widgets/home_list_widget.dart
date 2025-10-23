import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/features/home/data/model/home_page_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeListWidget extends StatelessWidget {
  final String title;
  final String seeAll;
  final String? link;
  final double listHeight;
  final List<Book> books;

  const HomeListWidget({
    super.key,
    required this.title,
    this.seeAll = 'همه',
    this.link,
    required this.listHeight,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
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
                onTap: () {
                  context.push('/book-list', extra: title);
                },
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
        const SizedBox(height: 8),
        SizedBox(
          height: listHeight,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              final double bookHeight = book.type == 'صوتی' ? 120 : 200;

              return Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: bookHeight,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 10.8,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      context.push('/book/${book.id}');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        fadeInDuration: const Duration(milliseconds: 300),
                        placeholder: (context, url) => Center(
                          child: LoadingAnimationWidget.flickr(
                            leftDotColor: AppColors.primary,
                            rightDotColor: AppColors.secondary,
                            size: 30,
                          ),
                        ),
                        imageUrl: book.picture,
                        fit: BoxFit.cover,
                        width: 120,
                        height: bookHeight,
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 16),
          ),
        ),
      ],
    );
  }
}
