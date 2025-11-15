import 'package:flutter/material.dart';

@immutable
abstract class PaymentStatus {}

class PaymentInitial extends PaymentStatus {}

class PaymentLoading extends PaymentStatus {}

class PaymentSuccess extends PaymentStatus {
  final Map<String, dynamic> result;
  PaymentSuccess({required this.result});
}

class PaymentError extends PaymentStatus {
  final String error;
  PaymentError({required this.error});
}
