import 'package:bazargan/config/router/route_paths.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/widgets/list_item_widget.dart';
import 'package:bazargan/core/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

final List<Map<String, String>> categories = [
  {'title': 'رمان', 'icon': Images.category1Black},
  {'title': 'تاریخ', 'icon': Images.category1Black},
  {'title': 'علم', 'icon': Images.category1Black},
  {'title': 'فیلسوفی', 'icon': Images.category1Black},
  {'title': 'مدیریت', 'icon': Images.category1Black},
  {'title': 'سفر در زمان', 'icon': Images.category1Black},
  {'title': 'دینی', 'icon': Images.category1Black},
  {'title': 'کسب و کار', 'icon': Images.category1Black},
  {'title': 'سیاسی', 'icon': Images.category1Black},
  {'title': 'علوم اجتماعی', 'icon': Images.category1Black},
  {'title': 'علوم پزشکی', 'icon': Images.category1Black},
  {'title': 'علوم زیستی', 'icon': Images.category1Black},
  {'title': 'نجوم', 'icon': Images.category1Black},
  {'title': 'نقد و ارزیابی', 'icon': Images.category1Black},
  {'title': 'فیزیک', 'icon': Images.category1Black},
  {'title': 'ریاضیات', 'icon': Images.category1Black},
];

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
            Expanded(
              child: ListView.separated(
                // shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Column(
                    children: [
                      const SizedBox(height: 8),
                      ListItemWidget(
                        title: category['title']!,
                        rightIcon: SvgPicture.asset(category['icon']!),
                        onPressed: () {},
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                },
                separatorBuilder: (context, index) =>
                    const Divider(color: AppColors.neutralE3E3E3, thickness: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
