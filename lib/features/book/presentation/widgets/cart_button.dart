import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:bazargan/features/cart/presentation/bloc/load_cart_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/utils/number_formater.dart';
import 'package:bazargan/config/router/route_paths.dart';
import 'package:go_router/go_router.dart';

class CartButton extends StatefulWidget {
  final double top;
  const CartButton({super.key, required this.top});

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(LoadCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      right: 0,
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.loadCartStatus is CartLoading) {
            return const SizedBox.shrink();
          }
          if (state.loadCartStatus is CartError) {
            return Center(child: Text('.'));
          }
          if (state.loadCartStatus is CartSuccess) {
            final cart = (state.loadCartStatus as CartSuccess).cartModel.results
                .map((e) => e.cartItems.length)
                .reduce((a, b) => a + b);
            if (cart == 0) {
              return const SizedBox.shrink();
            }
            return Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      GoRouter.of(context).push(RoutePaths.cart);
                    },
                    icon: Icon(
                      Iconsax.bag_2_copy,
                      size: 22,
                      color: AppColors.primary,
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        formatNumberToPersian(cart),
                        style: AppTextStyles.small.copyWith(
                          color: AppColors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
