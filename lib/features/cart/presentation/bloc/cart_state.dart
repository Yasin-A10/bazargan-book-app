part of 'cart_bloc.dart';

class CartState {
  final LoadCartStatus loadCartStatus;
  final DeleteCartStatus deleteCartStatus;
  final AddCouponStatus addCouponStatus;
  final CouponResultModel? couponResult;

  CartState({
    required this.loadCartStatus,
    required this.deleteCartStatus,
    required this.addCouponStatus,
    this.couponResult,
  });

  CartState copyWith({
    LoadCartStatus? newLoadCartStatus,
    DeleteCartStatus? newDeleteCartStatus,
    AddCouponStatus? newAddCouponStatus,
    CouponResultModel? newCouponResult,
  }) {
    return CartState(
      loadCartStatus: newLoadCartStatus ?? loadCartStatus,
      deleteCartStatus: newDeleteCartStatus ?? deleteCartStatus,
      addCouponStatus: newAddCouponStatus ?? addCouponStatus,
      couponResult: newCouponResult ?? couponResult,
    );
  }
}
