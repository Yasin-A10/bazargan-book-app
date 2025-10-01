part of 'favorite_bloc.dart';

abstract class FavoriteEvent {}

class LoadFavoriteEvent extends FavoriteEvent {}

class AddFavoriteEvent extends FavoriteEvent {
  final List<int> categoryIds;

  AddFavoriteEvent({required this.categoryIds});
}
