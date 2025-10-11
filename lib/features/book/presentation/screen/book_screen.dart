import 'dart:ui';

import 'package:bazargan/config/router/route_paths.dart';
import 'package:bazargan/core/blocs/all_books.dart/bloc/all_books_bloc.dart';
import 'package:bazargan/core/blocs/all_books.dart/data/model/all_books_model.dart';
import 'package:bazargan/core/blocs/all_books.dart/data/repository/all_books_repository_impl.dart';
import 'package:bazargan/core/blocs/all_books.dart/data/source/all_books_api_provider.dart';
import 'package:bazargan/core/blocs/audio/audio_bloc.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/utils/number_formater.dart';
import 'package:bazargan/core/utils/validators.dart';
import 'package:bazargan/core/widgets/button/button.dart';
import 'package:bazargan/core/widgets/inputs/star_rating.dart';
import 'package:bazargan/core/widgets/inputs/text_form_field.dart';
import 'package:bazargan/core/widgets/list_item_widget.dart';
import 'package:bazargan/core/widgets/list_widget.dart';
import 'package:bazargan/features/book/data/model/add_comment_model.dart';
import 'package:bazargan/features/book/data/model/book_model.dart';
import 'package:bazargan/features/book/presentation/bloc/add_to_cart/add_to_cart_bloc.dart';
import 'package:bazargan/features/book/presentation/bloc/book/book_bloc.dart';
import 'package:bazargan/features/book/presentation/bloc/book_commet/book_comment_bloc.dart';
import 'package:bazargan/features/book/presentation/widgets/audio_player_box.dart';
import 'package:bazargan/features/book/presentation/widgets/book_comment_card.dart';
import 'package:bazargan/features/book/presentation/widgets/cart_button.dart';
import 'package:bazargan/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:bazargan/features/my_library_bookmarks/presentation/bloc/add_marked_book_status.dart';
import 'package:bazargan/features/my_library_bookmarks/presentation/bloc/load_marked_book_status.dart';
import 'package:bazargan/features/my_library_bookmarks/presentation/bloc/marked_books_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BookScreen extends StatefulWidget {
  final int bookId;
  const BookScreen({super.key, required this.bookId});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final GlobalKey<FormState> _addCommentFormKey = GlobalKey<FormState>();

  //comment infos
  final TextEditingController _commentController = TextEditingController();
  int _rating = 0;
  int _picture = 0;
  String _name = '';

  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  bool? _isMarked = false;

  bool _isInCart = false;

  // initial queries
  AllBooksQuery authorBooksQuery = AllBooksQuery();
  AllBooksQuery publisherBooksQuery = AllBooksQuery();

  // blocs
  AllBooksBloc? authorBloc;
  AllBooksBloc? publisherBloc;

  _addComment(BuildContext context) {
    if (!_addCommentFormKey.currentState!.validate()) {
      return;
    }

    if (_rating == 0) {
      GoRouter.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.primary,
          content: Text('لطفا یک نمره بدهید'),
        ),
      );
      return;
    }

    BlocProvider.of<BookCommentBloc>(context).add(
      AddCommentEvent(
        bookId: widget.bookId,
        addCommentModel: AddCommentModel(
          rate: _rating,
          text: _commentController.text,
          book: BookCommentBookModel(name: _name, picture: _picture),
        ),
      ),
    );

    GoRouter.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.tertiary,
        content: Text('نظر شما با موفقیت اضافه شد'),
      ),
    );

    BlocProvider.of<BookCommentBloc>(
      context,
    ).add(LoadBookCommentEvent(bookId: widget.bookId));
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset > 40 && !_isScrolled) {
        setState(() => _isScrolled = true);
      } else if (_scrollController.offset <= 40 && _isScrolled) {
        setState(() => _isScrolled = false);
      }
    });

    BlocProvider.of<BookBloc>(
      context,
    ).add(LoadBookEvent(bookId: widget.bookId));
    BlocProvider.of<BookCommentBloc>(
      context,
    ).add(LoadBookCommentEvent(bookId: widget.bookId));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
    publisherBloc?.close();
    authorBloc?.close();
    _commentController.dispose();
    _rating = 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookBloc, BookState>(
      listener: (context, state) {
        if (state is BookSuccess) {
          final book = state.book;

          if (book.author.isNotEmpty && book.author.first.id != null) {
            authorBloc =
                AllBooksBloc(
                  repository: AllBooksRepositoryImpl(
                    apiProvider: AllBooksApiProvider(),
                  ),
                )..add(
                  LoadAllBooksEvent(
                    query: AllBooksQuery(
                      author: book.author.first.id.toString(),
                    ),
                  ),
                );
          }

          if (book.publisher?.id != null) {
            publisherBloc =
                AllBooksBloc(
                  repository: AllBooksRepositoryImpl(
                    apiProvider: AllBooksApiProvider(),
                  ),
                )..add(
                  LoadAllBooksEvent(
                    query: AllBooksQuery(
                      publisher: book.publisher!.id.toString(),
                    ),
                  ),
                );
          }
        }
      },
      builder: (context, state) {
        if (state is BookLoading) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: AppColors.primary,
                thirdRingColor: AppColors.secondary,
                secondRingColor: AppColors.tertiary,
                size: 40,
              ),
            ),
          );
        }

        if (state is BookError) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Center(child: Text(state.error)),
          );
        }

        if (state is BookSuccess) {
          final book = state.book;

          if (book.isMarked == true) {
            _isMarked = true;
          }

          if (book.author.first.id != null) {
            authorBooksQuery = AllBooksQuery(
              author: book.author.first.id.toString(),
            );
          }

          if (book.publisher?.id != null) {
            publisherBooksQuery = AllBooksQuery(
              publisher: book.publisher?.id.toString(),
            );
          }

          if (book.id != null) {
            _picture = book.id!;
          }

          if (book.name != null) {
            _name = book.name!;
          }

          if (book.isInCart != null) {
            _isInCart = book.isInCart ?? false;
          }

          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              shape: LinearBorder.bottom(
                side: BorderSide(
                  color: !_isScrolled
                      ? Colors.transparent
                      : AppColors.neutralEDEDED,
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              flexibleSpace: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: _isScrolled ? Colors.white : Colors.transparent,
              ),
              title: Text(book.name!, style: AppTextStyles.headlineLarge),
              leading: IconButton(
                icon: const Icon(
                  Iconsax.arrow_right_1_copy,
                  color: AppColors.neutral353535,
                  size: 16,
                ),
                onPressed: () => context.go('/'),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Iconsax.more_copy,
                    color: AppColors.neutral353535,
                    size: 16,
                  ),
                  onPressed: () {
                    _openMenu(context, book);
                  },
                ),
              ],
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 400,
                            width: double.infinity,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ImageFiltered(
                                  imageFilter: ImageFilter.blur(
                                    sigmaX: 0,
                                    sigmaY: 0,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: book.picture!,
                                    fit: BoxFit.cover,
                                    fadeInDuration: const Duration(
                                      microseconds: 300,
                                    ),
                                    placeholder: (context, url) => Center(
                                      child: LoadingAnimationWidget.flickr(
                                        leftDotColor: AppColors.primary,
                                        rightDotColor: AppColors.secondary,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        AppColors.white.withValues(alpha: 0.7),
                                        AppColors.white.withValues(alpha: 0.9),
                                        AppColors.white.withValues(alpha: 1.0),
                                      ],
                                      stops: const [0.0, 0.6, 1.0],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 120,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Column(
                                spacing: 8,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.3,
                                          ),
                                          blurRadius: 10.8,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        imageUrl: book.picture!,
                                        height: 200,
                                        width: 136,
                                        fit: BoxFit.cover,
                                        fadeInDuration: const Duration(
                                          microseconds: 300,
                                        ),
                                        placeholder: (context, url) => Center(
                                          child: LoadingAnimationWidget.flickr(
                                            leftDotColor: AppColors.primary,
                                            rightDotColor: AppColors.secondary,
                                            size: 50,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    spacing: 4,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Iconsax.share_copy,
                                          color: AppColors.secondary,
                                          size: 24,
                                        ),
                                      ),
                                      Row(
                                        spacing: 4,
                                        children: [
                                          Icon(
                                            Iconsax.star_1,
                                            color: AppColors.primary,
                                            size: 16,
                                          ),
                                          Text(
                                            formatNumberToPersian(
                                              book.avgRate ?? 0,
                                            ),
                                            style: AppTextStyles.small.copyWith(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            '(${formatNumberToPersian(book.rateCount ?? 0)})',
                                            style: AppTextStyles.small,
                                          ),
                                        ],
                                      ),
                                      BlocConsumer<
                                        MarkedBooksBloc,
                                        MarkedBooksState
                                      >(
                                        listener: (context, state) {
                                          if (state.addMarkedBookStatus
                                              is AddMarkedBookSuccess) {
                                            final bookmark =
                                                (state.addMarkedBookStatus
                                                        as AddMarkedBookSuccess)
                                                    .bookmark;
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    AppColors.tertiary,
                                                content: Text(
                                                  bookmark['message'],
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          }
                                          if (state.addMarkedBookStatus
                                              is AddMarkedBookError) {
                                            final bookmark =
                                                (state.addMarkedBookStatus
                                                        as AddMarkedBookError)
                                                    .error;

                                            setState(
                                              () => _isMarked = !_isMarked!,
                                            );
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    AppColors.primary,
                                                content: Text(
                                                  bookmark,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        builder: (context, state) {
                                          final isLoading =
                                              state.loadMarkedBooksStatus
                                                  is MarkedBooksLoading;

                                          return IconButton(
                                            onPressed: isLoading
                                                ? null
                                                : () {
                                                    setState(() {
                                                      _isMarked = !_isMarked!;
                                                    });
                                                    context
                                                        .read<MarkedBooksBloc>()
                                                        .add(
                                                          AddBookmarkEvent(
                                                            bookId: book.id!,
                                                          ),
                                                        );
                                                  },
                                            icon: isLoading
                                                ? SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color: AppColors
                                                              .secondary,
                                                        ),
                                                  )
                                                : Icon(
                                                    _isMarked!
                                                        ? Iconsax.save_2
                                                        : Iconsax.save_2_copy,
                                                    color: AppColors.secondary,
                                                    size: 24,
                                                  ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      Text(book.name!, style: AppTextStyles.headlineLarge),
                      SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          spacing: 8,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BookInfoList(
                              title: "نویسنده:",
                              infos: book.author
                                  .map(
                                    (e) => InfoItem(id: e.id!, name: e.name!),
                                  )
                                  .toList(),
                              hasArrow: true,
                              filterType: 'author',
                            ),

                            if (book.translator.isNotEmpty)
                              BookInfoList(
                                title: "مترجم:",
                                infos: book.translator
                                    .map(
                                      (e) => InfoItem(id: e.id!, name: e.name!),
                                    )
                                    .toList(),
                                hasArrow: true,
                                filterType: 'translator',
                              ),

                            BookInfoList(
                              title: "انتشارات:",
                              infos: [
                                InfoItem(
                                  id: book.publisher!.id!,
                                  name: book.publisher!.name!,
                                ),
                              ],
                              hasArrow: true,
                              filterType: 'publisher',
                            ),
                            BookInfoList(
                              title: "دسته بندی:",
                              infos: book.categories
                                  .map(
                                    (e) => InfoItem(id: e.id!, name: e.title!),
                                  )
                                  .toList(),
                              hasArrow: true,
                              filterType: 'category',
                            ),
                            BookInfoList(
                              title: "تعداد صفحات:",
                              infos: [
                                InfoItem(
                                  id: null,
                                  name: formatNumberToPersian(
                                    book.pageCount ?? 0,
                                  ),
                                ),
                              ],
                              filterType: '',
                            ),
                            BookInfoList(
                              title: "تاریخ انتشار:",
                              infos: [
                                InfoItem(
                                  id: null,
                                  name: formatNumberToPersianWithoutSeparator(
                                    book.editionYear.toString(),
                                  ),
                                ),
                              ],
                              filterType: '',
                            ),
                            BookInfoList(
                              title: "نوع کتاب:",
                              infos: [
                                InfoItem(id: null, name: book.type.toString()),
                              ],
                              filterType: '',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      Row(
                        spacing: 4,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            formatNumberToPersian(book.price!),
                            style: AppTextStyles.headlineLarge.copyWith(
                              fontSize: 20,
                              color: AppColors.secondary,
                            ),
                          ),
                          SvgPicture.asset(
                            Images.tooman,
                            width: 16,
                            height: 16,
                          ),
                        ],
                      ),
                      SizedBox(height: 12),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          spacing: 12,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Button(
                              label: 'خرید مستقیم',
                              onPressed: () {
                                _openPayMent(context, book);
                              },
                            ),
                            Expanded(
                              child: BlocConsumer<AddToCartBloc, AddToCartState>(
                                listener: (context, state) {
                                  if (state is AddToCartSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.tertiary,
                                        content: Text(state.response),
                                      ),
                                    );
                                    setState(() {
                                      _isInCart = true;
                                    });
                                  }
                                  if (state is AddToCartError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.primary,
                                        content: Text('خطا در خرید...'),
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return Button(
                                    label: _isInCart == true
                                        ? 'موجود در سبد'
                                        : 'افزودن به سبد',
                                    onPressed: state is AddToCartLoading
                                        ? null
                                        : () {
                                            _isInCart == true
                                                ? context.push(RoutePaths.cart)
                                                : context
                                                      .read<AddToCartBloc>()
                                                      .add(
                                                        AddToCartRequestEvent(
                                                          bookId: book.id!,
                                                        ),
                                                      );
                                            BlocProvider.of<CartBloc>(
                                              context,
                                            ).add(LoadCartEvent());
                                            _isInCart = true;
                                          },
                                    backgroundColor: AppColors.primaryTint8,
                                    textColor: AppColors.primary,
                                    icon: Icon(
                                      _isInCart == true
                                          ? Iconsax.bag_tick_2_copy
                                          : Iconsax.bag_2_copy,
                                      size: 20,
                                      color: AppColors.primary,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Button(
                          width: double.infinity,
                          label: 'نمونه',
                          onPressed: () {
                            _openSample(context, book);
                          },
                          icon: Icon(
                            book.type == 'صوتی'
                                ? Iconsax.play_copy
                                : Iconsax.book_1_copy,
                            size: 20,
                            color: AppColors.secondary,
                          ),
                          backgroundColor: AppColors.white,
                          textColor: AppColors.secondary,
                          borderColor: AppColors.secondary,
                        ),
                      ),
                      SizedBox(height: 16),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Text(
                              "معرفی کتاب",
                              style: AppTextStyles.headlineLarge,
                            ),
                            Text(
                              book.description ?? 'توضیحاتی موجود نیست',
                              textAlign: TextAlign.justify,
                              style: AppTextStyles.body.copyWith(
                                fontWeight: FontWeight.w300,
                                height: 1.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),

                      //! Comments list
                      BlocBuilder<BookCommentBloc, BookCommentState>(
                        builder: (context, state) {
                          if (state is BookCommentLoading) {
                            return Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: AppColors.primary,
                                size: 30,
                              ),
                            );
                          }

                          if (state is BookCommentError) {
                            return Center(child: Text(state.error));
                          }

                          if (state is BookCommentSuccess) {
                            final bookComments = state.bookComment;

                            if (bookComments.count == 0) {
                              return SizedBox.shrink();
                            }

                            return SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                itemCount: bookComments.results.length,
                                itemBuilder: (context, index) {
                                  final comment = bookComments.results[index];

                                  return BookCommentCard(
                                    bookId: widget.bookId,
                                    commentId: comment.id,
                                    title: comment.user.displayName,
                                    rating: comment.rate,
                                    date: comment.createdAt,
                                    comment: comment.text,
                                    isLiked: comment.feedback.hasLiked,
                                    isDisLiked: comment.feedback.hasDisliked,
                                    likeCount: comment.feedback.likeCount,
                                    dislikeCount: comment.feedback.dislikeCount,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 16),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      SizedBox(height: 16),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Button(
                          label: 'افزودن نظر',
                          onPressed: () {
                            _openReviewMenu(context);
                          },
                          width: double.infinity,
                          backgroundColor: AppColors.white,
                          textColor: AppColors.primary,
                          borderColor: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 24),

                      //! BlocBuilder for author books
                      if (authorBloc != null)
                        BlocBuilder<AllBooksBloc, AllBooksState>(
                          bloc: authorBloc,
                          builder: (context, state) {
                            if (state is AllBooksLoading) {
                              return Center(
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                  color: AppColors.primary,
                                  size: 30,
                                ),
                              );
                            }
                            if (state is AllBooksError) {
                              return Center(child: Text(state.error));
                            }
                            if (state is AllBooksSuccess) {
                              final authorBooks = state.bookListModel.results;
                              return ListWidget(
                                title: 'سایر کتاب‌های این نویسنده',
                                listHeight: 200,
                                books: authorBooks,
                                onTap: () => context.pushNamed(
                                  'books',
                                  queryParameters: {
                                    'title': 'سایر کتاب های این نویسنده',
                                    'type': 'author',
                                    'value': authorBooks.first.author.first.id
                                        .toString(),
                                  },
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),

                      //! BlocBuilder for publisher books
                      if (publisherBloc != null)
                        BlocBuilder<AllBooksBloc, AllBooksState>(
                          bloc: publisherBloc,
                          builder: (context, state) {
                            if (state is AllBooksLoading) {
                              return const SizedBox.shrink();
                            }
                            if (state is AllBooksError) {
                              return Center(child: Text(state.error));
                            }
                            if (state is AllBooksSuccess) {
                              final publisherBooks =
                                  state.bookListModel.results;
                              return ListWidget(
                                title: 'سایر کتاب‌های این ناشر',
                                listHeight: 200,
                                books: publisherBooks,
                                onTap: () => context.pushNamed(
                                  'books',
                                  queryParameters: {
                                    'title': 'سایر کتاب های این ناشر',
                                    'type': 'publisher',
                                    'value': publisherBooks.first.publisher.id
                                        .toString(),
                                  },
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      SizedBox(height: 88),
                    ],
                  ),
                ),

                CartButton(top: 130),
                const Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AudioPlayerBox(),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _openSample(BuildContext context, BookModel book) {
    if (book.type == 'pdf' && book.demo!.isNotEmpty) {
      context.push(RoutePaths.pdfViewer, extra: book.demo);
    }

    if (book.type == 'epub' && book.demo!.isNotEmpty) {
      // go to epub reader
    }

    if (book.type == 'صوتی' && book.demo!.isNotEmpty) {
      context.read<AudioBloc>().add(
        PlayAudio(url: book.demo!, title: book.name!, image: book.picture!),
      );
    }
  }

  void _openMenu(BuildContext context, BookModel book) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    transform: GradientRotation(0.4),
                    colors: [
                      AppColors.primary.withValues(alpha: 0.4),
                      AppColors.neutralMidnight.withValues(alpha: 0.2),
                      AppColors.secondary.withValues(alpha: 0.4),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 16,
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(
                        color: AppColors.neutral757575,
                        thickness: 3,
                        endIndent: 140,
                        indent: 140,
                      ),
                      const SizedBox(height: 16),
                      Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                      const SizedBox(height: 8),
                      ListItemWidget(
                        title: 'فهرست کتاب',
                        titleStyle: AppTextStyles.body.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        rightIcon: Icon(
                          Iconsax.menu_1_copy,
                          size: 20,
                          color: AppColors.neutralMidnight,
                        ),
                        leftIcon: Iconsax.arrow_left_2_copy,
                        onPressed: () {
                          _openCategoryMenu(context, book.indexes);
                        },
                      ),
                      const SizedBox(height: 8),
                      Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                      const SizedBox(height: 8),
                      ListItemWidget(
                        title: 'افزودن نظر',
                        titleStyle: AppTextStyles.body.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        rightIcon: Icon(
                          Iconsax.messages_3_copy,
                          size: 20,
                          color: AppColors.neutralMidnight,
                        ),
                        leftIcon: Iconsax.arrow_left_2_copy,
                        onPressed: () {
                          _openReviewMenu(context);
                        },
                      ),
                      const SizedBox(height: 8),
                      Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                      const SizedBox(height: 8),
                      const SizedBox(height: 8),
                      ListItemWidget(
                        title: 'شناسنامه اثر',
                        titleStyle: AppTextStyles.body.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        rightIcon: Icon(
                          Iconsax.book_copy,
                          size: 20,
                          color: AppColors.neutralMidnight,
                        ),
                        leftIcon: Iconsax.arrow_left_2_copy,
                        onPressed: () {
                          _openBookInfo(context, book);
                        },
                      ),
                      const SizedBox(height: 8),
                      Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _openCategoryMenu(BuildContext context, List<Index> indexes) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(
                color: AppColors.neutral757575,
                thickness: 3,
                endIndent: 140,
                indent: 140,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: indexes.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          indexes[index].title!,
                          style: AppTextStyles.body.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openReviewMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  color: AppColors.neutral757575,
                  thickness: 3,
                  endIndent: 140,
                  indent: 140,
                ),
                Text(
                  'ثبت نظر',
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 0),
                Column(
                  spacing: 8,
                  children: [
                    Text(
                      'چگونه یک درون گرای تاثیر گذار باشیم',
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    StarRating(
                      maxRating: 5,
                      onRatingChanged: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                  ],
                ),
                Form(
                  key: _addCommentFormKey,
                  child: InputTextFormField(
                    label: 'متن نظر',
                    keyboardType: TextInputType.text,
                    maxLines: 6,
                    controller: _commentController,
                    validator: (value) {
                      return AppValidator.userName(value, fieldName: 'متن نظر');
                    },
                  ),
                ),
                BlocConsumer<BookCommentBloc, BookCommentState>(
                  listener: (context, state) {
                    if (state is AddCommentSuccess) {
                      // Navigator.of(context).pop();
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //     backgroundColor: AppColors.tertiary,
                      //     content: Text('نظر شما با موفقیت اضافه شد'),
                      //   ),
                      // );
                    }

                    if (state is AddCommentError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.primary,
                          content: Text(state.error),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Button(
                      label: 'افزودن نظر',
                      onPressed: state is AddCommentLoading
                          ? null
                          : () {
                              _addComment(context);
                            },
                      width: double.infinity,
                      backgroundColor: AppColors.secondary,
                      textColor: AppColors.white,
                    );
                  },
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openBookInfo(BuildContext context, BookModel book) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  color: AppColors.neutral757575,
                  thickness: 3,
                  endIndent: 140,
                  indent: 140,
                ),
                Text(
                  'شناسنامه اثر',
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                BookInfoList(
                  title: "نویسنده:",
                  infos: book.author
                      .map((x) => InfoItem(id: x.id, name: x.name.toString()))
                      .toList(),
                  hasArrow: true,
                  filterType: 'author',
                ),
                if (book.translator.isNotEmpty)
                  BookInfoList(
                    title: "مترجم:",
                    infos: book.translator
                        .map((x) => InfoItem(id: x.id, name: x.name.toString()))
                        .toList(),
                    hasArrow: true,
                    filterType: 'translator',
                  ),
                BookInfoList(
                  title: "انتشارات:",
                  infos: book.publisher != null
                      ? [
                          InfoItem(
                            id: book.publisher?.id,
                            name: book.publisher!.name.toString(),
                          ),
                        ]
                      : [],
                  hasArrow: true,
                  filterType: 'publisher',
                ),
                BookInfoList(
                  title: "دسته بندی:",
                  infos: book.categories
                      .map((x) => InfoItem(id: x.id, name: x.title.toString()))
                      .toList(),
                  hasArrow: true,
                  filterType: 'category',
                ),
                BookInfoList(
                  title: "تعداد صفحات:",
                  infos: [
                    InfoItem(
                      id: null,
                      name: formatNumberToPersian(book.pageCount!),
                    ),
                  ],
                  filterType: '',
                ),
                BookInfoList(
                  title: "قیمت نسخه چاپی:",
                  infos: [
                    InfoItem(
                      id: null,
                      name: formatNumberToPersian(book.price!),
                    ),
                  ],
                  filterType: '',
                ),
                BookInfoList(
                  title: "تاریخ انتشار:",
                  infos: [
                    InfoItem(
                      id: null,
                      name: formatNumberToPersianWithoutSeparator(
                        book.editionYear.toString(),
                      ),
                    ),
                  ],
                  filterType: '',
                ),
                BookInfoList(
                  title: "شابک:",
                  infos: [
                    InfoItem(
                      id: null,
                      name: formatNumberToPersianWithoutSeparator(
                        book.ISBN.toString(),
                      ),
                    ),
                  ],
                  filterType: '',
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}

void _openPayMent(BuildContext context, BookModel book) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  transform: GradientRotation(0.4),
                  colors: [
                    AppColors.primary.withValues(alpha: 0.4),
                    AppColors.neutralMidnight.withValues(alpha: 0.2),
                    AppColors.secondary.withValues(alpha: 0.4),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 16,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(
                      color: AppColors.neutral757575,
                      thickness: 3,
                      endIndent: 140,
                      indent: 140,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'خرید مستقیم',
                      style: AppTextStyles.headlineLarge.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: book.picture!,
                              width: 75,
                              height: 110,
                              fit: BoxFit.cover,
                              fadeInDuration: const Duration(milliseconds: 300),
                              placeholder: (context, url) => Center(
                                child: LoadingAnimationWidget.flickr(
                                  leftDotColor: AppColors.primary,
                                  rightDotColor: AppColors.secondary,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 110,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  book.name!,
                                  style: AppTextStyles.headlineLarge,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      formatNumberToPersian(book.price!),
                                      style: AppTextStyles.headlineLarge
                                          .copyWith(
                                            color: AppColors.secondary,
                                            fontSize: 16,
                                          ),
                                    ),
                                    const SizedBox(width: 4),
                                    SvgPicture.asset(
                                      Images.tooman,
                                      width: 16,
                                      height: 16,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: InputTextFormField(label: 'کد تخفیف')),
                        const SizedBox(width: 16),
                        Button(
                          label: 'اعمال',
                          onPressed: () {},
                          backgroundColor: AppColors.secondary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Button(
                      label: 'پرداخت',
                      onPressed: () {},
                      width: double.infinity,
                      backgroundColor: AppColors.primary,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

//! for book info list
class InfoItem {
  final int? id;
  final String name;

  InfoItem({required this.id, required this.name});
}

class BookInfoList extends StatelessWidget {
  final String title;
  // final List<dynamic> infos;
  final List<InfoItem> infos;
  final bool hasArrow;
  final String filterType;

  const BookInfoList({
    super.key,
    required this.title,
    required this.infos,
    required this.filterType,
    this.hasArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.headlineMedium.copyWith(fontSize: 10)),

        const SizedBox(width: 8),
        const Expanded(
          child: Divider(color: AppColors.neutralE3E3E3, thickness: 1),
        ),
        const SizedBox(width: 8),

        ...infos.map((info) {
          final displayText = info.name.length > 14
              ? '${info.name.substring(0, 14)}.'
              : info.name;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: hasArrow
                  ? () {
                      context.pushNamed(
                        'books',
                        queryParameters: {
                          'title': info.name,
                          'type': filterType,
                          'value': info.id.toString(),
                        },
                      );
                    }
                  : null,
              child: Row(
                children: [
                  Text(
                    displayText,
                    style: AppTextStyles.headlineMedium,
                    overflow: TextOverflow.ellipsis, // برای اطمینان
                    maxLines: 1,
                  ),
                  if (hasArrow)
                    const Icon(
                      Iconsax.arrow_left_2_copy,
                      size: 16,
                      color: AppColors.neutral757575,
                    ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

// class BookInfoList extends StatelessWidget {
//   final String title;
//   final List<dynamic> infos;
//   final bool hasArrow;

//   const BookInfoList({
//     super.key,
//     required this.title,
//     required this.infos,
//     this.hasArrow = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: AppTextStyles.headlineMedium.copyWith(fontSize: 10)),
//         const SizedBox(width: 8),

//         // Divider کوتاه‌تر
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.5,
//           child: Divider(color: AppColors.neutralE3E3E3, thickness: 1),
//         ),
//         const SizedBox(width: 8),

//         // Wrap کل فضا رو بگیره
//         Expanded(
//           child: Wrap(
//             spacing: 4,
//             runSpacing: 2,
//             children: infos.map((info) {
//               return InkWell(
//                 onTap: hasArrow ? () {} : null,
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(info, style: AppTextStyles.headlineMedium),
//                     if (hasArrow)
//                       const Icon(
//                         Iconsax.arrow_left_2_copy,
//                         size: 16,
//                         color: AppColors.neutral757575,
//                       ),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }
