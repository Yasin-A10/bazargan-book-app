import 'package:bazargan/features/profile/data/model/user_model.dart';
import 'package:bazargan/features/profile/data/repository/user_repository_impl.dart';
import 'package:bazargan/features/profile/data/repository/update_name_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';
part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepositoryImpl userRepository;
  final UpdateNameRepositoryImpl updateNameRepository;

  UserBloc({required this.userRepository, required this.updateNameRepository})
    : super(UserInitial()) {
    // User
    on<UserEvent>((event, emit) async {
      emit(UserLoading());

      try {
        final Either<String, UserModel> result = await userRepository.getUser();

        result.fold(
          (error) => emit(UserError(error: error)),
          (user) => emit(UserSuccess(user: user)),
        );
      } catch (e) {
        emit(UserError(error: 'ارور بخش بلاک ${e.toString()}'));
      }
    });

    // Update Name
    on<UpdateNameEvent>((event, emit) async {
      emit(UpdateNameLoading());

      try {
        final Either<String, Map<String, dynamic>> result =
            await updateNameRepository.updateName(event.name);

        result.fold(
          (error) => emit(UpdateNameError(error: error)),
          (user) => emit(UpdateNameSuccess(user: user)),
        );
      } catch (e) {
        emit(UpdateNameError(error: 'ارور بخش بلاک ${e.toString()}'));
      }
    });
  }
}
