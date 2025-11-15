import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/utils/number_formater.dart';
import 'package:bazargan/core/utils/validators.dart';
import 'package:bazargan/core/widgets/button/button.dart';
import 'package:bazargan/core/widgets/inputs/text_form_field.dart';
import 'package:bazargan/features/cart/data/model/payment_model.dart';
import 'package:bazargan/features/cart/presentation/bloc/add_coupon_status.dart';
import 'package:bazargan/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:bazargan/features/cart/presentation/bloc/load_cart_status.dart';
import 'package:bazargan/features/cart/presentation/bloc/payment_status.dart';
import 'package:bazargan/features/cart/presentation/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<FormState> _couponFormKey = GlobalKey<FormState>();
  final TextEditingController _couponController = TextEditingController();

  bool _isCouponApplied = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartBloc>().add(LoadCartEvent());
    });
  }

  void _applyCoupon() {
    if (!_couponFormKey.currentState!.validate()) return;

    final cartUuid =
        (context.read<CartBloc>().state.loadCartStatus as CartSuccess)
            .cartModel
            .results
            .first
            .uuid;

    context.read<CartBloc>().add(
      AddCouponEvent(cartId: cartUuid, couponCode: _couponController.text),
    );
  }

  void _removeCoupon() {
    context.read<CartBloc>().add(RemoveCouponEvent());
    setState(() {
      _isCouponApplied = false;
      _couponController.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.tertiary,
        content: Text('کد تخفیف حذف شد'),
      ),
    );
  }

  void _addPayment(BuildContext context) {
    final cartUuid =
        (context.read<CartBloc>().state.loadCartStatus as CartSuccess)
            .cartModel
            .results
            .first
            .uuid;

    context.read<CartBloc>().add(
      _couponController.text.isNotEmpty
          ? AddPaymentEvent(
              cartId: cartUuid,
              paymentModel: PaymentModel(
                paymentMethod: "ON",
                paymentSource: "app",
                coupon: _couponController.text,
              ),
            )
          : AddPaymentEvent(
              cartId: cartUuid,
              paymentModel: PaymentModel(
                paymentMethod: "ON",
                paymentSource: "app",
              ),
            ),
    );
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

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
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.loadCartStatus is CartLoading) {
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: AppColors.primary,
                thirdRingColor: AppColors.secondary,
                secondRingColor: AppColors.tertiary,
                size: 40,
              ),
            );
          }

          if (state.loadCartStatus is CartError) {
            return Center(
              child: Text(
                (state.loadCartStatus as CartError).error,
                style: AppTextStyles.body,
              ),
            );
          }

          if (state.loadCartStatus is CartSuccess) {
            final cart = (state.loadCartStatus as CartSuccess).cartModel;

            final cartItem = cart.results.first;

            if (cartItem.cartItems.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Images.notFound, width: 140, height: 140),
                    const SizedBox(height: 20),
                    const Text(
                      'سبد خرید شما خالی است',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.neutralADADAD,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }

            int totalSellPrice;
            int yourProfitAmount;
            int totalFinalPrice;

            if (state.couponResult != null && cartItem.cartItems.isNotEmpty) {
              totalSellPrice = state.couponResult!.totalSellPrice;
              yourProfitAmount = state.couponResult!.yourProfitAmount;
              totalFinalPrice = state.couponResult!.totalFinalPrice;
            } else {
              totalSellPrice = cartItem.totalSellPrice;
              yourProfitAmount = cartItem.yourProfitAmount;
              totalFinalPrice = cartItem.totalFinalPrice;
            }

            return Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 16,
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItem.cartItems.length,
                        itemBuilder: (context, index) {
                          final book = cartItem.cartItems[index];
                          return CartCard(
                            cartId: book.id,
                            title: book.book.name,
                            author: book.book.author.first.name,
                            publisher: book.book.publisher.name,
                            price: book.book.price,
                            rate: book.book.avgRate ?? 0,
                            image: book.book.picture,
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
                        child: Form(
                          key: _couponFormKey,
                          child: Row(
                            children: [
                              Expanded(
                                child: InputTextFormField(
                                  label: 'کد تخفیف',
                                  controller: _couponController,
                                  readOnly: _isCouponApplied,
                                  validator: (value) {
                                    return AppValidator.userName(
                                      value,
                                      fieldName: 'کد تخفیف',
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              BlocListener<CartBloc, CartState>(
                                listenWhen: (previous, current) =>
                                    previous.addCouponStatus.runtimeType !=
                                    current.addCouponStatus.runtimeType,
                                listener: (context, state) {
                                  if (state.addCouponStatus
                                      is AddCouponSuccess) {
                                    setState(() {
                                      _isCouponApplied = true;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.tertiary,
                                        content: Text('کد تخفیف اعمال شد'),
                                      ),
                                    );
                                  }

                                  if (state.addCouponStatus is AddCouponError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.error,
                                        content: Text('کد تخفیف اعمال نشد'),
                                      ),
                                    );
                                  }
                                },
                                child: Button(
                                  label: _isCouponApplied ? 'حذف' : 'اعمال',
                                  onPressed: () {
                                    _isCouponApplied
                                        ? _removeCoupon()
                                        : _applyCoupon();
                                  },
                                  backgroundColor: _isCouponApplied
                                      ? AppColors.primary
                                      : AppColors.secondary,
                                ),
                              ),
                            ],
                          ),
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
                                  '${formatNumberToPersian(totalSellPrice)} تومان',
                                  style: AppTextStyles.small.copyWith(
                                    fontSize: 12,
                                  ),
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
                                  '${formatNumberToPersian(yourProfitAmount)} تومان',
                                  style: AppTextStyles.small.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 8,
                              children: [
                                Text(
                                  'سود شما از خرید:',
                                  style: AppTextStyles.small,
                                ),
                                Expanded(
                                  child: Divider(
                                    color: AppColors.neutralE3E3E3,
                                    thickness: 1,
                                  ),
                                ),
                                Text(
                                  '${formatNumberToPersian(yourProfitAmount)} تومان',
                                  style: AppTextStyles.small.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 8,
                              children: [
                                Text(
                                  'مبلغ قابل پرداخت:',
                                  style: AppTextStyles.small,
                                ),
                                Expanded(
                                  child: Divider(
                                    color: AppColors.neutralE3E3E3,
                                    thickness: 1,
                                  ),
                                ),
                                Text(
                                  '${formatNumberToPersian(totalFinalPrice)} تومان',
                                  style: AppTextStyles.headlineLarge.copyWith(
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 64),
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
                              'مجموع ${formatNumberToPersian(cartItem.cartItems.length)} کتاب',
                              style: AppTextStyles.body.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              formatNumberToPersian(totalFinalPrice),
                              style: AppTextStyles.headlineLarge.copyWith(
                                color: AppColors.secondary,
                              ),
                            ),
                            SvgPicture.asset(
                              Images.tooman,
                              width: 16,
                              height: 16,
                            ),
                          ],
                        ),
                        // Button(label: 'پرداخت', onPressed: () {}),
                        BlocConsumer<CartBloc, CartState>(
                          listener: (context, state) {
                            final paymentStatus = state.paymentStatus;

                            if (paymentStatus is PaymentSuccess) {
                              final paymentUrl = paymentStatus.result['url'];
                              if (paymentUrl != null) {
                                launchUrl(
                                  Uri.parse(paymentUrl),
                                  mode: LaunchMode.externalApplication,
                                );
                              }
                            }

                            if (paymentStatus is PaymentError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppColors.primary,
                                  content: Text('خطایی رخ داده است'),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            final isLoading =
                                state.paymentStatus is PaymentLoading;

                            return Button(
                              label: isLoading ? 'در حال پرداخت...' : 'پرداخت',
                              isLoading: isLoading,
                              onPressed: isLoading
                                  ? null
                                  : () => _addPayment(context),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
