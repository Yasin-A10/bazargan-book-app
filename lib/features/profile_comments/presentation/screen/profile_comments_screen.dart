import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/features/profile_comments/presentation/bloc/load_comment_status.dart';
import 'package:bazargan/features/profile_comments/presentation/bloc/user_comment_bloc.dart';
import 'package:bazargan/features/profile_comments/presentation/widgets/user_comment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileCommentsScreen extends StatefulWidget {
  const ProfileCommentsScreen({super.key});

  @override
  State<ProfileCommentsScreen> createState() => _ProfileCommentsScreenState();
}

class _ProfileCommentsScreenState extends State<ProfileCommentsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserCommentBloc>().add(LoadUserCommentEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نظرات من'),
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_right_1_copy,
            color: AppColors.neutral757575,
            size: 16,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<UserCommentBloc, UserCommentState>(
        builder: (context, state) {
          if (state.loadCommentStatus is CommentLoading) {
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: AppColors.primary,
                secondRingColor: AppColors.tertiary,
                thirdRingColor: AppColors.secondary,
                size: 40,
              ),
            );
          }
          if (state.loadCommentStatus is CommentError) {
            return Center(
              child: Text(
                (state.loadCommentStatus as CommentError).error,
                style: const TextStyle(color: AppColors.error, fontSize: 16),
              ),
            );
          }

          if (state.loadCommentStatus is CommentSuccess) {
            final comments =
                (state.loadCommentStatus as CommentSuccess).userCommentModel;

            return ListView.separated(
              itemCount: comments.results.length,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemBuilder: (context, index) {
                final comment = comments.results[index];
                return UserCommentCard(
                  bookId: comment.book.id,
                  commentId: comment.id,
                  bookName: comment.book.name,
                  title: comment.book.name,
                  rating: comment.rate,
                  date: comment.createdAt,
                  comment: comment.text,
                  image: comment.book.picture,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
