import 'package:bazargan/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class StarRating extends StatefulWidget {
  final int maxRating;
  final int? initialRating;
  final void Function(int rating)? onRatingChanged;

  const StarRating({
    super.key,
    this.maxRating = 5,
    this.onRatingChanged,
    this.initialRating = 0,
  });

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late int _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating ?? 0;
  }

  void _setRating(int rating) {
    setState(() {
      _currentRating = rating;
    });
    widget.onRatingChanged?.call(rating);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.maxRating, (index) {
          final starIndex = index + 1;
          final isFilled = starIndex <= _currentRating;

          return IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () => _setRating(starIndex),
            icon: Icon(
              isFilled ? Iconsax.star_1 : Iconsax.star_copy,
              color: AppColors.primary,
              size: 32,
            ),
          );
        }),
      ),
    );
  }
}
