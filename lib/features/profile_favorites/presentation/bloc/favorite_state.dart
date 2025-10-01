part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {
  final FavoriteCategoryModel favoriteCategoryModel;

  FavoriteSuccess({required this.favoriteCategoryModel});
}

class FavoriteError extends FavoriteState {
  final String error;

  FavoriteError({required this.error});
}

// add favorite state
class AddFavoriteLoading extends FavoriteState {}

class AddFavoriteSuccess extends FavoriteState {
  final Map<String, dynamic> categoryIds;

  AddFavoriteSuccess({required this.categoryIds});
}

class AddFavoriteError extends FavoriteState {
  final String error;

  AddFavoriteError({required this.error});
}
