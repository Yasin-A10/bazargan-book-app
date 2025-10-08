import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/widgets/card/book_card_row.dart';
import 'package:bazargan/features/my_library_bookmarks/presentation/bloc/marked_books_bloc.dart';
import 'package:bazargan/features/profile/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyLibraryBookmarksScreen extends StatelessWidget {
  const MyLibraryBookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MarkedBooksBloc>(context).add(LoadMarkedBooksEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('نشان شده ها'),
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_right_1_copy,
            color: AppColors.neutral757575,
            size: 16,
          ),
          onPressed: () {
            context.pop();
            BlocProvider.of<UserBloc>(context).add(LoadUserEvent());
          },
        ),
      ),
      body: BlocConsumer<MarkedBooksBloc, MarkedBooksState>(
        listener: (context, state) {
          if (state is AddBookmarkSuccess) {
            context.read<MarkedBooksBloc>().add(LoadMarkedBooksEvent());
          }
        },
        builder: (context, state) {
          if (state is MarkedBooksLoading) {
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: AppColors.primary,
                secondRingColor: AppColors.tertiary,
                thirdRingColor: AppColors.secondary,
                size: 40,
              ),
            );
          }

          if (state is MarkedBooksError) {
            return Center(child: Text(state.error));
          }

          if (state is MarkedBooksSuccess) {
            final books = state.markedBooksModel.results;
            return ListView.separated(
              itemCount: books.length,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final book = books[index];
                return BookCardRow(
                  bookId: book.id,
                  title: book.name,
                  author: book.author.first.name,
                  publisher: book.publisher.name,
                  price: book.price,
                  rate: book.avgRate,
                  image: book.thumbnail,
                  isSave: book.isMarked,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 24);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
