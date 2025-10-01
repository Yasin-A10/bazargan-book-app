import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/features/home/presentation/bloc/home_bloc.dart';
import 'package:bazargan/features/profile/presentation/bloc/user_bloc.dart';
import 'package:bazargan/features/profile_favorites/presentation/bloc/favorite_bloc.dart';
import 'package:bazargan/features/profile_favorites/presentation/widgets/category_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProfileFavoritesScreen extends StatefulWidget {
  const ProfileFavoritesScreen({super.key});

  @override
  State<ProfileFavoritesScreen> createState() => _ProfileFavoritesScreenState();
}

class _ProfileFavoritesScreenState extends State<ProfileFavoritesScreen> {
  final List<int> selectedCategoryIds = []; // 👈 تغییر دادیم

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadHomeEvent());
    BlocProvider.of<FavoriteBloc>(context).add(LoadFavoriteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('دسته بندی های مورد علاقه'),
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_right_1_copy,
            color: AppColors.neutral757575,
            size: 16,
          ),
          onPressed: () {
            BlocProvider.of<UserBloc>(context).add(LoadUserEvent());
            context.pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: BlocConsumer<FavoriteBloc, FavoriteState>(
              listener: (context, state) {
                if (state is AddFavoriteSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.tertiary,
                      content: Text('دسته بندی مورد علاقه اضافه شد'),
                    ),
                  );
                  context.read<FavoriteBloc>().add(LoadFavoriteEvent());
                }

                if (state is AddFavoriteError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.primary,
                      content: Text(state.error),
                    ),
                  );
                }
              },

              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    if (selectedCategoryIds.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.secondary,
                          content: Text(
                            'لطفا دسته بندی مورد علاقه انتخاب کنید',
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      );
                      return;
                    }
                    context.read<FavoriteBloc>().add(
                      AddFavoriteEvent(categoryIds: selectedCategoryIds),
                    );
                  },
                  child: state is AddFavoriteLoading
                      ? SizedBox(
                          height: 32,
                          width: 32,
                          child: const CircularProgressIndicator(),
                        )
                      : SvgPicture.asset(Images.tickButton, height: 32),
                );
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeError) {
            return Center(child: Text(state.message));
          }

          if (state is HomeSuccess) {
            final categories = state.homePageModel.categories;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        'جهت ارائه خدمات مفیدتر دسته بندی‌های مورد علاقه خود را انتخاب کنید',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.neutral757575,
                          fontWeight: FontWeight.w300,
                          height: 1.8,
                        ),
                      ),

                      const SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.neutralF9F9F9,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.neutralE3E3E3),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Iconsax.heart,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'انتخاب شده‌ها',
                                  style: AppTextStyles.body.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.neutral757575,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            BlocBuilder<FavoriteBloc, FavoriteState>(
                              builder: (context, state) {
                                if (state is FavoriteLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (state is FavoriteError) {
                                  return Center(child: Text(state.error));
                                }

                                if (state is FavoriteSuccess) {
                                  final favoriteCategories =
                                      state.favoriteCategoryModel;

                                  if (favoriteCategories.results == null ||
                                      favoriteCategories.results!.isEmpty) {
                                    return Text(
                                      'هیچ دسته‌بندی انتخاب نشده است',
                                      style: AppTextStyles.body.copyWith(
                                        color: AppColors.neutral757575,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    );
                                  }

                                  return Wrap(
                                    spacing: 8,
                                    runSpacing: 0,
                                    children: favoriteCategories.results!.map((
                                      category,
                                    ) {
                                      return Chip(
                                        label: Text(
                                          category.title!,
                                          style: AppTextStyles.body.copyWith(
                                            color: AppColors.tertiary,
                                          ),
                                        ),
                                        backgroundColor: AppColors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 0,
                                          vertical: 0,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: AppColors.tertiary,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      ListView.separated(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final category = categories[index];

                          final isSelected = selectedCategoryIds.contains(
                            category.id,
                          );

                          return CategoryItemWidget(
                            title: category.title,
                            icon: category.icon,
                            isSelectedIcon: category.icon,
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedCategoryIds.remove(category.id);
                                } else {
                                  selectedCategoryIds.add(category.id);
                                }
                              });
                            },
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                      ),
                    ],
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
