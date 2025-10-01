import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class IconSearch extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onPressed;
  const IconSearch({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, color: AppColors.neutral757575, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    title,
                    style: AppTextStyles.body,
                  ),
                ],
              ),
            ),
            Divider(thickness: 1, color: AppColors.neutralE3E3E3),
          ],
        ),
      ),
    );
  }
}

class BookSearch extends StatelessWidget {
  final String image;
  final double imgHeight;
  final String title;
  final Function() onPressed;
  const BookSearch({
    super.key,
    required this.image,
    required this.title,
    required this.onPressed,
    required this.imgHeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: imgHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neutralMidnight.withValues(
                            alpha: 0.2,
                          ),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 300),
                      fadeInCurve: Curves.easeInOut,
                      placeholder: (context, url) => Center(
                        child: LoadingAnimationWidget.flickr(
                          leftDotColor: AppColors.primary,
                          rightDotColor: AppColors.secondary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body,
                    ),
                  ),
                ],
              ),
            ),
            Divider(thickness: 1, color: AppColors.neutralE3E3E3),
          ],
        ),
      ),
    );
  }
}
