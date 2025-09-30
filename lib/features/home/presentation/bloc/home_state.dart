part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final HomePageModel homePageModel;
  HomeSuccess({required this.homePageModel});
}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}
