import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/utils/number_formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CartCard extends StatelessWidget {
  final String title;
  final String author;
  final String publisher;
  final String price;
  final String image;
  final String? discount;
  final String? rate;

  const CartCard({
    super.key,
    required this.title,
    required this.author,
    required this.publisher,
    required this.price,
    required this.image,
    this.discount,
    this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              width: 75,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 4,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.headlineLarge.copyWith(fontSize: 12),
                    ),
                  ),
                  Icon(Iconsax.trash_copy, color: AppColors.primary, size: 16),
                ],
              ),

              Text(author, style: AppTextStyles.small),
              Text(publisher, style: AppTextStyles.small),

              Row(
                children: [
                  Icon(Iconsax.star_1, color: AppColors.primary, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    formatNumberToPersianWithoutSeparator(rate ?? '0'),
                    style: AppTextStyles.small,
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    formatNumberToPersian(int.parse(price)),
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(Images.tooman, width: 16, height: 16),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
