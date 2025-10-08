import 'package:bazargan/config/router/route_paths.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/utils/number_formater.dart';
import 'package:bazargan/core/widgets/button/button.dart';
import 'package:bazargan/core/widgets/category_list.dart';
import 'package:bazargan/features/home/presentation/bloc/home_bloc.dart';
import 'package:bazargan/features/home/presentation/widgets/home_slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/widgets/home_list_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:bazargan/core/network/session_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('access token: ${SessionManager.instance.access}');
    final String bestSellerBooksTitle = 'پرفروشترین ها';
    final String popularBooksTitle = 'محبوب ترین ها';
    final String forYouTitle = 'بهترین ها برای تو';

    final homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(LoadHomeEvent());

    return Scaffold(
      appBar: AppBar(title: SvgPicture.asset(Images.bazarganRed, height: 40)),
      body: Stack(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return Center(
                  child: LoadingAnimationWidget.discreteCircle(
                    color: AppColors.primary,
                    thirdRingColor: AppColors.secondary,
                    secondRingColor: AppColors.tertiary,
                    size: 40,
                  ),
                );
              }

              if (state is HomeError) {
                return Center(child: Text(state.message));
              }

              if (state is HomeSuccess) {
                final categories = state.homePageModel.categories;
                final bestSellerBooks = state.homePageModel.bestSellerBooks;
                final popularBooks = state.homePageModel.popularBooks;
                final slider = state.homePageModel.slider;

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 16,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Button(
                          label: 'دسته‌بندی‌ها',
                          textColor: AppColors.secondary,
                          backgroundColor: AppColors.secondaryTint8,
                          width: double.infinity,
                          onPressed: () {},
                          icon: Icon(
                            Iconsax.element_3,
                            size: 20,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                      SizedBox(height: 0),

                      HomeSliderWidget(slider: slider),

                      SizedBox(height: 0),

                      HomeListWidget(
                        title: bestSellerBooksTitle,
                        listHeight: 200,
                        books: bestSellerBooks,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(color: AppColors.neutralE3E3E3),
                      ),

                      CategoryList(
                        title: 'دسته‌بندی',
                        listHeight: 80,
                        categories: categories,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(color: AppColors.neutralE3E3E3),
                      ),

                      HomeListWidget(
                        title: popularBooksTitle,
                        listHeight: 200,
                        books: popularBooks,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(color: AppColors.neutralE3E3E3),
                      ),

                      HomeListWidget(
                        title: forYouTitle,
                        listHeight: 200,
                        books: popularBooks,
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          CartButton(count: 3),
        ],
      ),
    );
  }
}

class CartButton extends StatelessWidget {
  final int count;
  const CartButton({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      right: 0,
      child: Container(
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
                  formatNumberToPersian(count),
                  style: AppTextStyles.small.copyWith(
                    color: AppColors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
