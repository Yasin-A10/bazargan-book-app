import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/widgets/search_bar.dart';
import 'package:bazargan/features/search/presentation/bloc/search_bloc.dart';
import 'package:bazargan/features/search/presentation/widgets/search_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class OriginalSearchScreen extends StatefulWidget {
  const OriginalSearchScreen({super.key});

  @override
  State<OriginalSearchScreen> createState() => _OriginalSearchScreenState();
}

class _OriginalSearchScreenState extends State<OriginalSearchScreen> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("جستجو"),
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_right_1_copy,
            color: AppColors.neutral757575,
            size: 16,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          children: [
            CustomSearchBar(
              hintText: "جستجو در نام کتاب، نویسنده، ناشر و ...",
              focusNode: _focusNode,
              onSearch: (value) {
                if (value.isNotEmpty) {
                  context.read<SearchBloc>().add(
                    LoadSearchEvent(search: value),
                  );
                } else {
                  context.read<SearchBloc>().add(ClearSearchEvent());
                }
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return const Center(
                      child: Text("لطفاً عبارتی برای جستجو وارد کنید."),
                    );
                  }

                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is SearchSuccess) {
                    final search = state.searchModel;

                    return ListView(
                      children: [
                        if (search.authors.isNotEmpty)
                          ...search.authors.map(
                            (author) => IconSearch(
                              icon: Iconsax.user_edit_copy,
                              title: author.name,
                              onPressed: () {},
                            ),
                          ),
                        if (search.publishers.isNotEmpty)
                          ...search.publishers.map(
                            (pub) => IconSearch(
                              icon: Iconsax.printer_copy,
                              title: pub.name,
                              onPressed: () {},
                            ),
                          ),
                        if (search.categories.isNotEmpty)
                          ...search.categories.map(
                            (cat) => IconSearch(
                              icon: Iconsax.category_copy,
                              title: cat.title,
                              onPressed: () {},
                            ),
                          ),
                        if (search.translators.isNotEmpty)
                          ...search.translators.map(
                            (tr) => IconSearch(
                              icon: Iconsax.translate_copy,
                              title: tr.name,
                              onPressed: () {},
                            ),
                          ),

                        if (search.audioBooks.isNotEmpty)
                          ...search.audioBooks.map(
                            (book) => BookSearch(
                              image: book.picture,
                              title: book.name,
                              imgHeight: 22,
                              onPressed: () {},
                            ),
                          ),
                        if (search.eBooks.isNotEmpty)
                          ...search.eBooks.map(
                            (book) => BookSearch(
                              image: book.picture,
                              title: book.name,
                              imgHeight: 30,
                              onPressed: () {},
                            ),
                          ),
                      ],
                    );
                  }

                  if (state is SearchError) {
                    return Center(
                      child: Text(
                        state.error,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
