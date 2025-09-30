import 'package:bazargan/config/router/route_paths.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/widgets/list_item_widget.dart';
import 'package:bazargan/core/widgets/search_bar.dart';
import 'package:bazargan/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

// final List<Map<String, String>> categories = [
//   {'title': 'رمان', 'icon': Images.category1Black},
//   {'title': 'تاریخ', 'icon': Images.category1Black},
//   {'title': 'علم', 'icon': Images.category1Black},
//   {'title': 'فیلسوفی', 'icon': Images.category1Black},
//   {'title': 'مدیریت', 'icon': Images.category1Black},
//   {'title': 'سفر در زمان', 'icon': Images.category1Black},
//   {'title': 'دینی', 'icon': Images.category1Black},
//   {'title': 'کسب و کار', 'icon': Images.category1Black},
//   {'title': 'سیاسی', 'icon': Images.category1Black},
//   {'title': 'علوم اجتماعی', 'icon': Images.category1Black},
//   {'title': 'علوم پزشکی', 'icon': Images.category1Black},
//   {'title': 'علوم زیستی', 'icon': Images.category1Black},
//   {'title': 'نجوم', 'icon': Images.category1Black},
//   {'title': 'نقد و ارزیابی', 'icon': Images.category1Black},
//   {'title': 'فیزیک', 'icon': Images.category1Black},
//   {'title': 'ریاضیات', 'icon': Images.category1Black},
// ];

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('جستجو')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FakeSearchBar(onTap: () => context.push(RoutePaths.search)),
            const SizedBox(height: 16),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is HomeError) {
                  return Center(child: Text(state.message));
                }
                if (state is HomeSuccess) {
                  final categories = state.homePageModel.categories;
                  return Expanded(
                    child: ListView.separated(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return Column(
                          children: [
                            const SizedBox(height: 8),
                            ListItemWidget(
                              title: category.title,
                              rightIcon: SvgPicture.network(
                                category.icon,
                                colorFilter: ColorFilter.mode(
                                  AppColors.neutralMidnight,
                                  BlendMode.srcIn,
                                ),
                                width: 20,
                                height: 20,
                              ),
                              onPressed: () {},
                            ),
                            const SizedBox(height: 8),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        color: AppColors.neutralE3E3E3,
                        thickness: 1,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
