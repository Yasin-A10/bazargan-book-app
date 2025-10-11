import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/utils/number_formater.dart';
import 'package:bazargan/features/my_library_bookmarks/presentation/bloc/add_marked_book_status.dart';
import 'package:bazargan/features/my_library_bookmarks/presentation/bloc/marked_books_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:bazargan/config/router/route_paths.dart';

class BookCardRow extends StatefulWidget {
  final int bookId;
  final String title;
  final String author;
  final String publisher;
  final int price;
  final String image;
  final String? discount;
  final double? rate;
  final bool? isSave;

  const BookCardRow({
    super.key,
    required this.bookId,
    required this.title,
    required this.author,
    required this.publisher,
    required this.price,
    required this.image,
    this.discount,
    this.rate,
    this.isSave,
  });

  @override
  State<BookCardRow> createState() => _BookCardRowState();
}

class _BookCardRowState extends State<BookCardRow> {
  late bool _isSaved;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.isSave ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.push(RoutePaths.book, extra: widget.bookId),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                width: 75,
                height: 110,
                fit: BoxFit.cover,
                imageUrl: widget.image,
                fadeInDuration: const Duration(milliseconds: 300),
                placeholder: (context, url) => Center(
                  child: LoadingAnimationWidget.flickr(
                    leftDotColor: AppColors.primary,
                    rightDotColor: AppColors.tertiary,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.headlineLarge.copyWith(fontSize: 12),
                    ),
                  ),

                  BlocConsumer<MarkedBooksBloc, MarkedBooksState>(
                    listener: (context, state) {
                      if (state.addMarkedBookStatus is AddMarkedBookSuccess) {
                        setState(() {
                          isLoading = false;
                        });
                      }

                      if (state.addMarkedBookStatus is AddMarkedBookError) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    builder: (context, state) {
                      return IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: isLoading
                            ? null
                            : () {
                                setState(() {
                                  isLoading = true;
                                  _isSaved = !_isSaved;
                                });

                                context.read<MarkedBooksBloc>().add(
                                  AddBookmarkEvent(bookId: widget.bookId),
                                );
                              },
                        icon: isLoading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                  color: AppColors.secondary,
                                ),
                              )
                            : Icon(
                                _isSaved ? Iconsax.save_2 : Iconsax.save_2_copy,
                                color: AppColors.secondary,
                                size: 18,
                              ),
                      );
                    },
                  ),
                ],
              ),

              Text(widget.author, style: AppTextStyles.small),
              Text(widget.publisher, style: AppTextStyles.small),

              Row(
                children: [
                  const Icon(
                    Iconsax.star_1,
                    color: AppColors.primary,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    formatNumberToPersianWithoutSeparator(
                      (widget.rate ?? 0).toStringAsFixed(1),
                    ),
                    style: AppTextStyles.small,
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    formatNumberToPersian(widget.price),
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(Images.tooman, width: 16, height: 16),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
