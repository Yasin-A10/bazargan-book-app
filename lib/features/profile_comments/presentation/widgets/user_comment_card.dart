import 'package:bazargan/config/router/route_paths.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/utils/convert_to_jalali.dart';
import 'package:bazargan/core/utils/number_formater.dart';
import 'package:bazargan/core/utils/validators.dart';
import 'package:bazargan/core/widgets/button/button.dart';
import 'package:bazargan/core/widgets/inputs/star_rating.dart';
import 'package:bazargan/core/widgets/inputs/text_form_field.dart';
import 'package:bazargan/core/widgets/show_star_rating.dart';
import 'package:bazargan/features/profile_comments/data/model/update_comment_model.dart';
import 'package:bazargan/features/profile_comments/presentation/bloc/delete_comment_status.dart';
import 'package:bazargan/features/profile_comments/presentation/bloc/update_comment_status.dart';
import 'package:bazargan/features/profile_comments/presentation/bloc/user_comment_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserCommentCard extends StatefulWidget {
  final int bookId;
  final int commentId;
  final String bookName;
  final String title;
  final double? rating;
  final String date;
  final String comment;
  final String image;
  const UserCommentCard({
    super.key,
    required this.bookId,
    required this.commentId,
    required this.bookName,
    required this.title,
    required this.rating,
    required this.date,
    required this.comment,
    required this.image,
  });

  @override
  State<UserCommentCard> createState() => _UserCommentCardState();
}

class _UserCommentCardState extends State<UserCommentCard> {
  final GlobalKey<FormState> _updateCommentFormKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  int? _rating;

  @override
  void initState() {
    super.initState();
    _commentController.text = widget.comment;
    _rating = widget.rating?.toInt();
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  context.push(RoutePaths.book, extra: widget.bookId);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.30),
                        blurRadius: 10.8,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: widget.image,
                      fadeInDuration: const Duration(milliseconds: 300),
                      placeholder: (context, url) => Center(
                        child: LoadingAnimationWidget.flickr(
                          leftDotColor: AppColors.primary,
                          rightDotColor: AppColors.secondary,
                          size: 20,
                        ),
                      ),
                      width: 44,
                      height: 65,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.neutralMidnight,
                    ),
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      ShowStarRating(rating: widget.rating?.toInt() ?? 0),
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
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                spacing: 16,
                children: [
                  InkWell(
                    onTap: () {
                      _openEdit(context);
                    },
                    child: SvgPicture.asset(Images.edit, width: 20, height: 20),
                  ),
                  InkWell(
                    onTap: () {
                      _openDelete(context);
                    },
                    child: SvgPicture.asset(
                      Images.trash,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            widget.comment,
            textAlign: TextAlign.justify,
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w300,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }

  void _openEdit(BuildContext context) {
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
                      widget.bookName,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    StarRating(
                      initialRating: _rating,
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
                  key: _updateCommentFormKey,
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
                BlocConsumer<UserCommentBloc, UserCommentState>(
                  listener: (context, state) {
                    if (state.updateCommentStatus is UpdateCommentSuccess) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.tertiary,
                          content: Text('نظر شما با موفقیت ثبت شد'),
                        ),
                      );
                    }

                    if (state.updateCommentStatus is UpdateCommentError) {
                      Navigator.pop(context);
                      // final error =
                      //     (state.updateCommentStatus as UpdateCommentError)
                      //         .error;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.primary,
                          content: Text('نمیتوان آپدیت کرد...'),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Button(
                      label: 'افزودن نظر',
                      onPressed:
                          state.updateCommentStatus is UpdateCommentLoading
                          ? null
                          : () {
                              if (!_updateCommentFormKey.currentState!
                                  .validate()) {
                                return;
                              }
                              if (_rating == 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: AppColors.error,
                                    content: Text('لطفاً نکات را انتخاب کنید'),
                                  ),
                                );
                                return;
                              }
                              context.read<UserCommentBloc>().add(
                                UpdateUserCommentEvent(
                                  commentId: widget.commentId,
                                  updateCommentModel: UpdateCommentModel(
                                    rate: _rating!.toDouble(),
                                    text: _commentController.text,
                                    book: UpdateCommentBook(
                                      name: widget.bookName,
                                      picture: widget.bookId,
                                    ),
                                  ),
                                ),
                              );
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

  void _openDelete(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 20,
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
                'حذف نظر',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
              Text(
                'آیا نسبت به حذف نظر خود اطمینان دارید؟',
                style: AppTextStyles.small.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                ),
              ),
              Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: Button(
                      label: 'بازگشت',
                      onPressed: () {
                        context.pop();
                      },
                      width: double.infinity,
                      backgroundColor: AppColors.white,
                      textColor: AppColors.secondary,
                      borderColor: AppColors.secondary,
                    ),
                  ),
                  Expanded(
                    child: BlocConsumer<UserCommentBloc, UserCommentState>(
                      listener: (context, state) {
                        if (state.deleteCommentStatus is DeleteCommentSuccess) {
                          context.pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.tertiary,
                              content: Text('نظر شما با موفقیت حذف شد'),
                            ),
                          );
                        }

                        if (state.deleteCommentStatus is DeleteCommentError) {
                          context.pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.primary,
                              content: Text('نمیتوان نظر را حذف کرد...'),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Button(
                          label: 'حذف',
                          onPressed:
                              state.deleteCommentStatus is DeleteCommentLoading
                              ? null
                              : () {
                                  context.read<UserCommentBloc>().add(
                                    DeleteUserCommentEvent(
                                      commentId: widget.commentId,
                                    ),
                                  );
                                },
                          width: double.infinity,
                          backgroundColor: AppColors.primary,
                          textColor: AppColors.white,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
