part of 'cart_bloc.dart';

abstract class CartEvent {}

class LoadCartEvent extends CartEvent {}

class DeleteCartEvent extends CartEvent {
  final int cartId;
  DeleteCartEvent({required this.cartId});
}

class AddCouponEvent extends CartEvent {
  final String cartId;
  final String couponCode;
  AddCouponEvent({required this.cartId, required this.couponCode});
}

class RemoveCouponEvent extends CartEvent {}

class AddPaymentEvent extends CartEvent {
  final String cartId;
  final PaymentModel paymentModel;
  AddPaymentEvent({required this.cartId, required this.paymentModel});
}
