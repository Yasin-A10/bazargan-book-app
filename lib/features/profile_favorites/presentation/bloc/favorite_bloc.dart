import 'package:bazargan/features/profile_favorites/data/model/favorite_category_model.dart';
import 'package:bazargan/features/profile_favorites/data/repository/add_favorite_repository_impl.dart';
import 'package:bazargan/features/profile_favorites/data/repository/favorite_category_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_state.dart';
part 'favorite_event.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteCategoryRepositoryImpl favoriteCategoryRepository;
  final AddFavoriteRepositoryImpl addFavoriteRepository;

  FavoriteBloc({
    required this.favoriteCategoryRepository,
    required this.addFavoriteRepository,
  }) : super(FavoriteInitial()) {
    on<FavoriteEvent>((event, emit) async {
      emit(FavoriteLoading());

      try {
        final Either<String, FavoriteCategoryModel> result =
            await favoriteCategoryRepository.getFavoriteCategories();

        result.fold(
          (error) => emit(FavoriteError(error: error)),
          (favoriteCategoryModel) => emit(
            FavoriteSuccess(favoriteCategoryModel: favoriteCategoryModel),
          ),
        );
      } catch (e) {
        emit(FavoriteError(error: 'ارور بخش بلاک ${e.toString()}'));
      }
    });

    // add favorite
    on<AddFavoriteEvent>((event, emit) async {
      emit(AddFavoriteLoading());

      try {
        final Either<String, Map<String, dynamic>> result =
            await addFavoriteRepository.addFavorite(event.categoryIds);

        result.fold(
          (error) => emit(AddFavoriteError(error: error)),
          (data) => emit(AddFavoriteSuccess(categoryIds: data)),
        );
      } catch (e) {
        emit(AddFavoriteError(error: 'ارور بخش بلاک ${e.toString()}'));
      }
    });
  }
}
