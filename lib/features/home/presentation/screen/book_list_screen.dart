import 'package:bazargan/core/api/all_books.dart/bloc/all_books_bloc.dart';
import 'package:bazargan/core/api/all_books.dart/data/model/all_books_model.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/widgets/card/book_card_column.dart';
import 'package:bazargan/core/widgets/card/book_card_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BookListScreen extends StatefulWidget {
  final String title;
  final String type;
  final dynamic param;
  const BookListScreen({
    super.key,
    required this.title,
    required this.param,
    required this.type,
  });

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  bool isColumn = false;

  @override
  void initState() {
    super.initState();

    final query = AllBooksQuery(
      categories: widget.type == 'category' ? widget.param : null,
      author: widget.type == 'author' ? widget.param : null,
      publisher: widget.type == 'publisher' ? widget.param : null,
      translator: widget.type == 'translator' ? widget.param : null,
      narrator: widget.type == 'narrator' ? widget.param : null,
    );

    BlocProvider.of<AllBooksBloc>(context).add(LoadAllBooksEvent(query: query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: AppTextStyles.headlineLarge.copyWith(fontSize: 14),
        ),
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_right_1_copy,
            color: AppColors.neutral757575,
            size: 16,
          ),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: isColumn
                ? const Icon(
                    Iconsax.element_3_copy,
                    size: 16,
                    color: AppColors.neutral757575,
                  )
                : const Icon(
                    Iconsax.row_vertical_copy,
                    size: 16,
                    color: AppColors.neutral757575,
                  ),
            onPressed: () => setState(() => isColumn = !isColumn),
          ),
        ],
      ),
      body: BlocBuilder<AllBooksBloc, AllBooksState>(
        builder: (context, state) {
          if (state is AllBooksLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AllBooksError) {
            return Center(child: Text(state.error));
          }

          if (state is AllBooksSuccess) {
            final books = state.bookListModel;
            return AnimatedSwitcher(
              switchInCurve: Curves.easeInOutCubic,
              switchOutCurve: Curves.easeInOutCubic,
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(scale: animation, child: child),
                );
              },
              child: isColumn
                  ? ListView.separated(
                      itemCount: books.results.length,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        final book = books.results[index];
                        return BookCardRow(
                          publisher: book.publisher.name,
                          bookId: book.id,
                          title: book.name,
                          author: book.author.first.name,
                          price: book.price,
                          rate: book.avgRate,
                          image: book.picture,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16);
                      },
                    )
                  : GridView.builder(
                      itemCount: books.results.length,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.5,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 16,
                          ),
                      itemBuilder: (context, index) {
                        final book = books.results[index];
                        return BookCardColumn(
                          bookId: book.id,
                          title: book.name,
                          author: book.author.first.name,
                          publisher: book.publisher.name,
                          price: book.price,
                          rate: book.avgRate,
                          image: book.picture,
                        );
                      },
                    ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
