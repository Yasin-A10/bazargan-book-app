import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/widgets/button/button.dart';
import 'package:bazargan/core/widgets/inputs/text_form_field.dart';
import 'package:bazargan/features/cart/presentation/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:bazargan/core/constants/colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سبد خرید'),
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_right_1_copy,
            color: AppColors.neutral757575,
            size: 16,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const CartCard(
                      title: 'چگونه یک درونگرای تاثیر گذار باشیم',
                      author: 'حسین کاظمی یزدی',
                      publisher: 'انتشارات جیحون',
                      price: '100000',
                      rate: '4.5',
                      image: Images.listImg,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 16);
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(child: InputTextFormField(label: 'کد تخفیف')),
                      const SizedBox(width: 16),
                      Button(
                        label: 'اعمال',
                        onPressed: () {},
                        backgroundColor: AppColors.secondary,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    spacing: 8,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Text('جمع کل:', style: AppTextStyles.small),
                          Expanded(
                            child: Divider(
                              color: AppColors.neutralE3E3E3,
                              thickness: 1,
                            ),
                          ),
                          Text(
                            '۲۳۴٬۰۰۰ تومان',
                            style: AppTextStyles.small.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Text('تخفیف:', style: AppTextStyles.small),
                          Expanded(
                            child: Divider(
                              color: AppColors.neutralE3E3E3,
                              thickness: 1,
                            ),
                          ),
                          Text(
                            '۴٬۰۰۰ تومان',
                            style: AppTextStyles.small.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Text('سود شما از خرید:', style: AppTextStyles.small),
                          Expanded(
                            child: Divider(
                              color: AppColors.neutralE3E3E3,
                              thickness: 1,
                            ),
                          ),
                          Text(
                            '۳۴٬۰۰۰ تومان',
                            style: AppTextStyles.small.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Text('مبلغ قابل پرداخت:', style: AppTextStyles.small),
                          Expanded(
                            child: Divider(
                              color: AppColors.neutralE3E3E3,
                              thickness: 1,
                            ),
                          ),
                          Text(
                            '۲۳۰٬۰۰۰ تومان',
                            style: AppTextStyles.headlineLarge.copyWith(
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
                top: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Text(
                        'مجموع ۳ کتاب',
                        style: AppTextStyles.body.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '۲۳۰٬۰۰۰',
                        style: AppTextStyles.headlineLarge.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                      SvgPicture.asset(Images.tooman, width: 16, height: 16),
                    ],
                  ),
                  Button(label: 'پرداخت', onPressed: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
