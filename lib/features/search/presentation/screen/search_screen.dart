import 'package:bazargan/config/router/route_paths.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/widgets/list_item_widget.dart';
import 'package:bazargan/core/widgets/search_bar.dart';
import 'package:bazargan/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

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
                              onPressed: () {
                                context.pushNamed(
                                  'books',
                                  queryParameters: {
                                    'title': category.title,
                                    'type': 'category',
                                    'value': category.id.toString(),
                                  },
                                );
                              },
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
