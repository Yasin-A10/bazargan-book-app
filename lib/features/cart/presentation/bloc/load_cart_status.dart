import 'package:bazargan/features/cart/data/model/cart_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoadCartStatus {}

class CartInitial extends LoadCartStatus {}

class CartLoading extends LoadCartStatus {}

class CartSuccess extends LoadCartStatus {
  final CartModel cartModel;
  CartSuccess({required this.cartModel});
}

class CartError extends LoadCartStatus {
  final String error;
  CartError({required this.error});
}
