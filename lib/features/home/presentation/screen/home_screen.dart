import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/widgets/button/button.dart';
import 'package:bazargan/core/widgets/category_list.dart';
import 'package:bazargan/features/book/presentation/widgets/audio_player_box.dart';
import 'package:bazargan/features/book/presentation/widgets/cart_button.dart';
import 'package:bazargan/features/home/presentation/bloc/home_bloc.dart';
import 'package:bazargan/features/home/presentation/widgets/home_slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/widgets/home_list_widget.dart';
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

                      const SizedBox(height: 50),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          CartButton(top: 16),
          const Positioned(left: 0, right: 0, bottom: 0, child: MiniPlayer()),
        ],
      ),
    );
  }
}
