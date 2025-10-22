import 'package:bazargan/config/router/route_paths.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/widgets/button/button.dart';
import 'package:bazargan/core/widgets/card/my_library_card.dart';
import 'package:bazargan/features/book/presentation/widgets/audio_player_box.dart';
import 'package:bazargan/features/book/presentation/widgets/cart_button.dart';
import 'package:bazargan/features/my_library/presentation/bloc/load_my_books_status.dart';
import 'package:bazargan/features/my_library/presentation/bloc/my_library_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyLibraryScreen extends StatefulWidget {
  const MyLibraryScreen({super.key});

  @override
  State<MyLibraryScreen> createState() => _MyLibraryScreenState();
}

class _MyLibraryScreenState extends State<MyLibraryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyLibraryBloc>(context).add(LoadMyLibraryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('کتابخانه من')),
      body: BlocBuilder<MyLibraryBloc, MyLibraryState>(
        builder: (context, state) {
          if (state.loadMyBooksStatus is MyLibraryLoading) {
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: AppColors.primary,
                thirdRingColor: AppColors.secondary,
                secondRingColor: AppColors.tertiary,
                size: 40,
              ),
            );
          }

          if (state.loadMyBooksStatus is MyLibraryError) {
            final error = (state.loadMyBooksStatus as MyLibraryError).error;
            return Center(child: Text(error));
          }

          if (state.loadMyBooksStatus is MyLibrarySuccess) {
            final myLibraryModel =
                (state.loadMyBooksStatus as MyLibrarySuccess).myLibraryModel;
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      Button(
                        onPressed: () {
                          context.push(RoutePaths.myLibraryBookmarks);
                        },
                        label: 'نشانه‌دار ها',
                        backgroundColor: AppColors.secondaryTint8,
                        textColor: AppColors.secondary,
                        icon: Icon(Iconsax.bookmark_2, size: 20),
                      ),
                      GridView.builder(
                        itemCount: myLibraryModel.results.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.70,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                            ),
                        itemBuilder: (context, index) {
                          final book = myLibraryModel.results[index];
                          return MyLibraryCard(book: book);
                        },
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
                CartButton(top: 16),
                const Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: MiniPlayer(),
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
