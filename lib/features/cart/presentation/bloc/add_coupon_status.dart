import 'package:bazargan/features/cart/data/model/coupon_result_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AddCouponStatus {}

class AddCouponInitial extends AddCouponStatus {}

class AddCouponLoading extends AddCouponStatus {}

class AddCouponSuccess extends AddCouponStatus {
  final CouponResultModel result;
  AddCouponSuccess({required this.result});
}

class AddCouponError extends AddCouponStatus {
  final String error;
  AddCouponError({required this.error});
}
