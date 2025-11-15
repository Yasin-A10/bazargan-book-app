part of 'cart_bloc.dart';

class CartState {
  final LoadCartStatus loadCartStatus;
  final DeleteCartStatus deleteCartStatus;
  final AddCouponStatus addCouponStatus;
  final CouponResultModel? couponResult;
  final PaymentStatus paymentStatus;

  CartState({
    required this.loadCartStatus,
    required this.deleteCartStatus,
    required this.addCouponStatus,
    this.couponResult,
    required this.paymentStatus,
  });

  CartState copyWith({
    LoadCartStatus? newLoadCartStatus,
    DeleteCartStatus? newDeleteCartStatus,
    AddCouponStatus? newAddCouponStatus,
    CouponResultModel? newCouponResult,
    bool setCouponResult = false,
    PaymentStatus? newPaymentStatus,
  }) {
    return CartState(
      loadCartStatus: newLoadCartStatus ?? loadCartStatus,
      deleteCartStatus: newDeleteCartStatus ?? deleteCartStatus,
      addCouponStatus: newAddCouponStatus ?? addCouponStatus,
      couponResult: setCouponResult ? newCouponResult : couponResult,
      paymentStatus: newPaymentStatus ?? paymentStatus,
    );
  }
}
