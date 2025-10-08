part of 'add_to_cart_bloc.dart';

abstract class AddToCartEvent {}

class AddToCartRequestEvent extends AddToCartEvent {
  final int bookId;

  AddToCartRequestEvent({required this.bookId});
}
