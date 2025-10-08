import 'package:bazargan/features/profile_comments/data/model/user_comment_model.dart';
import 'package:bazargan/features/profile_comments/data/repository/user_comment_repository_impl.dart';
import 'package:bazargan/features/profile_comments/presentation/bloc/load_comment_status.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'user_comment_event.dart';
part 'user_comment_state.dart';

class UserCommentBloc extends Bloc<UserCommentEvent, UserCommentState> {
  final UserCommentRepositoryImpl userCommentRepository;

  UserCommentBloc({required this.userCommentRepository})
    : super(UserCommentState(loadCommentStatus: CommentInitial())) {
    // load user comments
    on<LoadUserCommentEvent>((event, emit) async {
      emit(state.copyWith(newLoadCommentStatus: CommentLoading()));

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
  }
}
