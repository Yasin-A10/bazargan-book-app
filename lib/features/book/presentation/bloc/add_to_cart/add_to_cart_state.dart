part of 'add_to_cart_bloc.dart';

@immutable
abstract class AddToCartState {}

class AddToCartInitial extends AddToCartState {}

class AddToCartLoading extends AddToCartState {}

class AddToCartSuccess extends AddToCartState {
  final String response;

  AddToCartSuccess({required this.response});
}

class AddToCartError extends AddToCartState {
  final String error;

  AddToCartError({required this.error});
}
