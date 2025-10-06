import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/utils/convert_to_jalali.dart';
import 'package:bazargan/core/utils/number_formater.dart';
import 'package:bazargan/core/widgets/show_star_rating.dart';
import 'package:bazargan/features/book/data/model/feedback_model.dart';
import 'package:bazargan/features/book/presentation/bloc/feedback/feedback_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookCommentCard extends StatefulWidget {
  final int bookId;
  final int commentId;
  final String? title;
  final double? rating;
  final String date;
  final String comment;
  final bool isLiked;
  final bool isDisLiked;
  final int likeCount;
  final int dislikeCount;

  const BookCommentCard({
    super.key,
    required this.bookId,
    required this.commentId,
    required this.title,
    this.rating,
    required this.date,
    required this.comment,
    required this.isLiked,
    required this.likeCount,
    required this.dislikeCount,
    required this.isDisLiked,
  });

  @override
  State<BookCommentCard> createState() => _BookCommentCardState();
}

class _BookCommentCardState extends State<BookCommentCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late bool _isLiked;
  late bool _isDisliked;
  late int _likeCount;
  late int _dislikeCount;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
    _isDisliked = widget.isDisLiked;
    _likeCount = widget.likeCount;
    _dislikeCount = widget.dislikeCount;
  }

  void _handleFeedback({required bool like}) {
    setState(() {
      if (like) {
        if (_isLiked) {
          _isLiked = false;
          _likeCount--;
        } else {
          _isLiked = true;
          _likeCount++;
          if (_isDisliked) {
            _isDisliked = false;
            _dislikeCount--;
          }
        }
      } else {
        if (_isDisliked) {
          _isDisliked = false;
          _dislikeCount--;
        } else {
          _isDisliked = true;
          _dislikeCount++;
          if (_isLiked) {
            _isLiked = false;
            _likeCount--;
          }
        }
      }
    });

    BlocProvider.of<FeedbackBloc>(context).add(
      AddFeedbackEvent(
        bookId: widget.bookId,
        commentId: widget.commentId,
        feedbackModel: FeedbackModel(
          type: like ? 'L' : 'D',
          comment: widget.commentId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final truncated = widget.comment.length > 180 && !_expanded
        ? "${widget.comment.substring(0, 180)}..."
        : widget.comment;

    return Container(
      width: 270,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title ?? 'بدون نام',
                        style: AppTextStyles.headlineMedium.copyWith(
                          color: AppColors.neutralMidnight,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          ShowStarRating(rating: widget.rating?.toInt() ?? 0),
                          const SizedBox(width: 6),
                          Text(
                            formatNumberToPersianWithoutSeparator(
                              convertToJalaliDate(widget.date),
                            ),
                            style: AppTextStyles.small.copyWith(
                              color: AppColors.neutral757575,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    // Like Button with Animation
                    InkWell(
                      onTap: () => _handleFeedback(like: true),
                      borderRadius: BorderRadius.circular(50),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, anim) =>
                                ScaleTransition(scale: anim, child: child),
                            child: Text(
                              formatNumberToPersian(_likeCount),
                              key: ValueKey(_likeCount),
                              style: AppTextStyles.small,
                            ),
                          ),
                          const SizedBox(width: 4),
                          AnimatedScale(
                            scale: _isLiked ? 1.2 : 1.0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            child: SvgPicture.asset(
                              _isLiked ? Images.likeBold : Images.like,
                              width: 16,
                              height: 16,
                              colorFilter: ColorFilter.mode(
                                AppColors.tertiary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Dislike Button with Animation
                    InkWell(
                      onTap: () => _handleFeedback(like: false),
                      borderRadius: BorderRadius.circular(50),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, anim) =>
                                ScaleTransition(scale: anim, child: child),
                            child: Text(
                              formatNumberToPersian(_dislikeCount),
                              key: ValueKey(_dislikeCount),
                              style: AppTextStyles.small,
                            ),
                          ),
                          const SizedBox(width: 4),
                          AnimatedScale(
                            scale: _isDisliked ? 1.2 : 1.0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            child: SvgPicture.asset(
                              _isDisliked ? Images.dislikeBold : Images.dislike,
                              width: 16,
                              height: 16,
                              colorFilter: ColorFilter.mode(
                                AppColors.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              truncated,
              textAlign: TextAlign.justify,
              style: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.w300,
                height: 1.8,
                color: AppColors.neutralMidnight,
              ),
            ),
            if (widget.comment.length > 180)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    _expanded ? 'نمایش کمتر' : 'نمایش بیشتر',
                    style: AppTextStyles.small.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
