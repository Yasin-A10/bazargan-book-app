part of 'cart_bloc.dart';

class CartState {
  final LoadCartStatus loadCartStatus;
  final DeleteCartStatus deleteCartStatus;

  CartState({required this.loadCartStatus, required this.deleteCartStatus});

  CartState copyWith({
    LoadCartStatus? newLoadCartStatus,
    DeleteCartStatus? newDeleteCartStatus,
  }) {
    return CartState(
      loadCartStatus: newLoadCartStatus ?? loadCartStatus,
      deleteCartStatus: newDeleteCartStatus ?? deleteCartStatus,
    );
  }
}
