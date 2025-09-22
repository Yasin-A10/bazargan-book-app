import 'package:bazargan/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ShowStarRating extends StatelessWidget {
  final int rating;
  final int maxRating;
  final double size;
  final Color filledColor;
  final Color emptyColor;

  const ShowStarRating({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 12,
    this.filledColor = AppColors.primary,
    this.emptyColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        if (index < rating) {
          return Icon(Iconsax.star_1, size: size, color: filledColor);
        } else {
          return Icon(Iconsax.star_copy, size: size, color: emptyColor);
        }
      }),
    );
  }
}
