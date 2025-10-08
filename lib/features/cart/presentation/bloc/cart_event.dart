part of 'cart_bloc.dart';

abstract class CartEvent {}

class LoadCartEvent extends CartEvent {}

class DeleteCartEvent extends CartEvent {
  final int cartId;
  DeleteCartEvent({required this.cartId});
}
