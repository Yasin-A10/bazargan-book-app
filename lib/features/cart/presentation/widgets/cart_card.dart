import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/utils/number_formater.dart';
import 'package:bazargan/core/widgets/button/button.dart';
import 'package:bazargan/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:bazargan/features/cart/presentation/bloc/delete_cart_status.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CartCard extends StatelessWidget {
  final int cartId;
  final String title;
  final String author;
  final String publisher;
  final int price;
  final String image;
  final String? discount;
  final double? rate;

  const CartCard({
    super.key,
    required this.cartId,
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
            child: CachedNetworkImage(
              imageUrl: image,
              width: 75,
              height: 110,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 300),
              placeholder: (context, url) => Center(
                child: LoadingAnimationWidget.flickr(
                  leftDotColor: AppColors.primary,
                  rightDotColor: AppColors.secondary,
                  size: 20,
                ),
              ),
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

                  InkWell(
                    borderRadius: BorderRadius.circular(6),
                    onTap: () {
                      _openDeleteDialog(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Iconsax.trash_copy,
                        color: AppColors.primary,
                        size: 16,
                      ),
                    ),
                  ),
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
                    formatNumberToPersian(price),
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

  void _openDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف کتاب از سبد'),
        content: const Text('آیا از حذف این کتاب مطمئن هستید؟'),
        actions: [
          Button(
            backgroundColor: AppColors.white,
            textColor: AppColors.primary,
            borderColor: AppColors.primary,
            borderWidth: 1,
            onPressed: () => Navigator.pop(context),
            label: 'لغو',
          ),
          BlocConsumer<CartBloc, CartState>(
            listener: (context, state) {
              if (state.deleteCartStatus is DeleteCartSuccess) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.tertiary,
                    content: Text('کتاب از سبد حذف شد'),
                  ),
                );
              }

              if (state.deleteCartStatus is DeleteCartError) {
                // final error = (state.deleteCartStatus as CartError).error;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.primary,
                    content: Text('خطا در حذف از سبد'),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Button(
                backgroundColor: AppColors.secondary,
                onPressed: state.deleteCartStatus is DeleteCartLoading
                    ? null
                    : () {
                        context.read<CartBloc>().add(
                          DeleteCartEvent(cartId: cartId),
                        );
                      },
                label: 'بله',
              );
            },
          ),
        ],
      ),
    );
  }
}
