import 'package:bazargan/features/profile_comments/data/model/update_comment_model.dart';
import 'package:bazargan/features/profile_comments/data/model/user_comment_model.dart';
import 'package:bazargan/features/profile_comments/data/repository/update_comment_repository_impl.dart';
import 'package:bazargan/features/profile_comments/data/repository/user_comment_repository_impl.dart';
import 'package:bazargan/features/profile_comments/presentation/bloc/load_comment_status.dart';
import 'package:bazargan/features/profile_comments/presentation/bloc/update_comment_status.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'user_comment_event.dart';
part 'user_comment_state.dart';

class UserCommentBloc extends Bloc<UserCommentEvent, UserCommentState> {
  final UserCommentRepositoryImpl userCommentRepository;
  final UpdateCommentRepositoryImpl updateCommentRepository;

  UserCommentBloc({
    required this.userCommentRepository,
    required this.updateCommentRepository,
  }) : super(
         UserCommentState(
           loadCommentStatus: CommentInitial(),
           updateCommentStatus: UpdateCommentInitial(),
         ),
       ) {
    // load user comments
    on<LoadUserCommentEvent>((event, emit) async {
      emit(
        state.copyWith(
          newLoadCommentStatus: CommentLoading(),
          newUpdateCommentStatus: UpdateCommentInitial(),
        ),
      );

      final Either<String, UserCommentModel> dataState =
          await userCommentRepository.getUserComments();

      dataState.fold(
        (left) => emit(
          state.copyWith(newLoadCommentStatus: CommentError(error: left)),
        ),
        (right) => emit(
          state.copyWith(
            newLoadCommentStatus: CommentSuccess(userCommentModel: right),
          ),
        ),
      );
    });

    // update user comment
    on<UpdateUserCommentEvent>((event, emit) async {
      emit(state.copyWith(newUpdateCommentStatus: UpdateCommentLoading()));

      final Either<String, UpdateCommentModel> dataState =
          await updateCommentRepository.updateComment(
            event.commentId,
            event.updateCommentModel,
          );

      await dataState.fold(
        (left) async {
          emit(
            state.copyWith(
              newUpdateCommentStatus: UpdateCommentError(error: left),
            ),
          );
        },
        (right) async {
          emit(
            state.copyWith(
              newUpdateCommentStatus: UpdateCommentSuccess(
                updateCommentModel: right,
              ),
            ),
          );

          final Either<String, UserCommentModel> refreshed =
              await userCommentRepository.getUserComments();

          refreshed.fold(
            (left) => emit(
              state.copyWith(newLoadCommentStatus: CommentError(error: left)),
            ),
            (right) => emit(
              state.copyWith(
                newLoadCommentStatus: CommentSuccess(userCommentModel: right),
              ),
            ),
          );
        },
      );
    });

    // on<UpdateUserCommentEvent>((event, emit) async {
    //   emit(state.copyWith(newUpdateCommentStatus: UpdateCommentLoading()));

    //   final Either<String, UpdateCommentModel> dataState =
    //       await updateCommentRepository.updateComment(
    //         event.commentId,
    //         event.updateCommentModel,
    //       );

    //   dataState.fold(
    //     (left) => emit(
    //       state.copyWith(
    //         newUpdateCommentStatus: UpdateCommentError(error: left),
    //       ),
    //     ),
    //     (right) => emit(
    //       state.copyWith(
    //         newUpdateCommentStatus: UpdateCommentSuccess(
    //           updateCommentModel: right,
    //         ),
    //       ),
    //     ),
    //   );
    // });
  }
}
